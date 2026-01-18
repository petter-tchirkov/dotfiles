#!/usr/bin/env node
"use strict";

const fs = require("fs");
const { URL, URLSearchParams } = require("url");
const { spawnSync } = require("child_process");

const DEVIANTART_HOST = "www.deviantart.com";
const USER_AGENT =
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 " +
  "(KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36";

function usage() {
  console.error(
    "Usage: da_subscriptions_scrape.js <url> --cookies <cookies.txt> [--max-pages N] [--start-page N] [--output file] [--download] [--gallery-dl path] [--verbose]"
  );
}

function parseArgs(argv) {
  const args = {
    url: null,
    cookies: null,
    maxPages: 50,
    startPage: 1,
    output: "deviations.txt",
    download: false,
    galleryDl: "gallery-dl",
    verbose: false,
  };

  if (argv.length < 3) return null;
  args.url = argv[2];

  for (let i = 3; i < argv.length; i += 1) {
    const key = argv[i];
    if (key === "--cookies") {
      args.cookies = argv[++i];
    } else if (key === "--max-pages") {
      args.maxPages = Number(argv[++i]);
    } else if (key === "--start-page") {
      args.startPage = Number(argv[++i]);
    } else if (key === "--output") {
      args.output = argv[++i];
    } else if (key === "--download") {
      args.download = true;
    } else if (key === "--gallery-dl") {
      args.galleryDl = argv[++i];
    } else if (key === "--verbose") {
      args.verbose = true;
    } else {
      console.error(`[warn] unknown arg: ${key}`);
    }
  }

  if (!args.url || !args.cookies) return null;
  return args;
}

function normalizeUrl(raw) {
  if (!/^https?:\/\//i.test(raw)) return `https://${raw.replace(/^\/+/, "")}`;
  return raw;
}

function loadNetscapeCookies(cookiePath) {
  const content = fs.readFileSync(cookiePath, "utf8");
  const cookies = [];
  for (const line of content.split(/\r?\n/)) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;
    const parts = trimmed.split("\t");
    if (parts.length !== 7) continue;
    const [domain, _flag, path, secure, _expiry, name, value] = parts;
    if (domain.startsWith("#")) continue;
    cookies.push({ domain, path, secure, name, value });
  }
  return cookies;
}

function buildCookieHeader(cookies, targetHost) {
  const host = targetHost.startsWith(".") ? targetHost.slice(1) : targetHost;
  const filtered = cookies.filter((c) => {
    const cd = c.domain.startsWith(".") ? c.domain.slice(1) : c.domain;
    return host === cd || host.endsWith(`.${cd}`);
  });
  const pairs = filtered.map((c) => `${c.name}=${c.value}`);
  return pairs.join("; ");
}

function buildPageUrl(baseUrl, page) {
  const urlObj = new URL(baseUrl);
  const params = new URLSearchParams(urlObj.search);
  if (!params.has("page")) params.set("page", String(page));
  else params.set("page", String(page));
  urlObj.search = params.toString();
  return urlObj.toString();
}

function extractDeviationIds(html) {
  const ids = new Set();
  const re = /"deviationId"\s*:\s*(\d+)/g;
  let match;
  while ((match = re.exec(html)) !== null) {
    ids.add(match[1]);
  }
  return ids;
}

function extractDeviationLinks(html) {
  const links = new Set();
  const re = /href="([^"]+)"/g;
  let match;
  while ((match = re.exec(html)) !== null) {
    const href = match[1];
    if (href.includes("/art/") || href.includes("/deviation/")) {
      links.add(href);
    }
  }
  return links;
}

function canonicalizeDeviationUrl(url) {
  if (!url.includes("/deviation/") && !url.includes("/art/")) return null;
  try {
    const u = new URL(url);
    if (u.pathname.includes("/art/")) {
      const match = u.pathname.match(/-(\d+)(?:\/)?$/);
      if (match) {
        u.pathname = `/deviation/${match[1]}`;
        u.search = "";
      }
    }
    u.hash = "";
    return u.toString();
  } catch {
    const cleaned = url.split("#")[0];
    const artMatch = cleaned.match(/\/art\/.*-(\d+)(?:\/)?$/);
    if (artMatch) return `https://${DEVIANTART_HOST}/deviation/${artMatch[1]}`;
    return cleaned;
  }
}

async function fetchPage(url, cookieHeader, verbose) {
  if (verbose) console.error(`[info] fetching ${url}`);
  const res = await fetch(url, {
    headers: {
      "User-Agent": USER_AGENT,
      Cookie: cookieHeader,
    },
  });
  return { status: res.status, text: await res.text() };
}

async function scrapeDeviations({ url, cookies, maxPages, startPage, verbose }) {
  const found = [];
  const seen = new Set();
  const cookieHeader = buildCookieHeader(cookies, DEVIANTART_HOST);

  for (let page = startPage; page < startPage + maxPages; page += 1) {
    const pageUrl = buildPageUrl(url, page);
    const { status, text } = await fetchPage(pageUrl, cookieHeader, verbose);
    if (status !== 200) {
      console.error(`[warn] page ${page} status ${status}; stopping`);
      break;
    }

    const ids = extractDeviationIds(text);
    const pageUrls = new Set();

    if (ids.size) {
      for (const id of ids) {
        pageUrls.add(`https://${DEVIANTART_HOST}/deviation/${id}`);
      }
    } else {
      for (const link of extractDeviationLinks(text)) {
        const full = new URL(link, `https://${DEVIANTART_HOST}`).toString();
        const canon = canonicalizeDeviationUrl(full);
        if (canon) pageUrls.add(canon);
      }
    }

    const newUrls = Array.from(pageUrls).filter((u) => !seen.has(u));
    if (!newUrls.length) {
      if (verbose) console.error(`[info] no new deviations on page ${page}; stopping`);
      break;
    }

    newUrls.sort();
    for (const u of newUrls) {
      seen.add(u);
      found.push(u);
    }
  }

  return found;
}

async function main() {
  const args = parseArgs(process.argv);
  if (!args) {
    usage();
    process.exit(2);
  }

  const url = normalizeUrl(args.url);
  if (!url.includes(DEVIANTART_HOST)) {
    console.error("[error] URL must be a DeviantArt subscription page");
    process.exit(2);
  }

  if (!fs.existsSync(args.cookies)) {
    console.error("[error] cookies file not found");
    process.exit(2);
  }

  const cookies = loadNetscapeCookies(args.cookies);
  const urls = await scrapeDeviations({
    url,
    cookies,
    maxPages: args.maxPages,
    startPage: args.startPage,
    verbose: args.verbose,
  });

  if (!urls.length) {
    console.error("[warn] no deviations found");
    process.exit(1);
  }

  fs.writeFileSync(args.output, urls.join("\n") + "\n", "utf8");
  console.error(`[info] wrote ${urls.length} URLs to ${args.output}`);

  if (args.download) {
    const result = spawnSync(args.galleryDl, ["-i", args.output], {
      stdio: "inherit",
    });
    process.exit(result.status ?? 0);
  }
}

main().catch((err) => {
  console.error(`[error] ${err.message}`);
  process.exit(1);
});
