// ==UserScript==
// @name         Auto Skip YouTube Ads
// @version      1.1.0
// @description  Speed up and skip YouTube ads automatically
// @author       jso8910 and others
// @match        *://*.youtube.com/*
// ==/UserScript==


// document.addEventListener('load', () => {
//     const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button-modern')
//     if (btn) {
//         btn.click()
//     }
//     const ad = [...document.querySelectorAll('.ad-showing')][0];
//     if (ad) {
//         document.querySelector('video').currentTime = 9999999999;
//     }
// }, true);


// document.addEventListener('load', () => {
//     try { document.querySelector('.ad-showing video').currentTime = 99999 } catch { }
//     try { document.querySelector('.ytp-ad-skip-button').click() } catch { }
// }, true);


GM_addStyle(`
#player-ads,
.adDisplay,
.ad-container,
.ytd-display-ad-renderer,
.video-ads,
ytd-rich-item-renderer:has(ytd-ad-slot-renderer),
ytd-ad-slot-renderer,
#masthead-ad,
*[class^="ytd-ad-"],
#panels.ytd-watch-flexy {
    display: none !important;
}`);

document.addEventListener('load', () => {
    let ad = document.querySelector('.ad-showing:has(.ytp-ad-persistent-progress-bar-container) video');
    let skipButton = document.querySelector('.ytp-ad-skip-button');

    if (ad) ad.currentTime = 99999;
    if (skipButton) skipButton.click();
}, true);
