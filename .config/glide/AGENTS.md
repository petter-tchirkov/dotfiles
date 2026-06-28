# Repository Guidelines

## Project Structure & Module Organization
- `glide.ts` is the config entry point for keymaps and browser options.
- `glide.d.ts` is generated type coverage for Glide APIs. Do not edit it by hand.
- `tsconfig.json` enforces strict, `esnext`-targeted TypeScript with `erasableSyntaxOnly`.
- `glide/` stores profile data and runtime state. Treat it as generated output, not source.

## Build, Test, and Development Commands
- `npm install` installs the local TypeScript dependency.
- `npm run tsc` checks the config with `tsc --noEmit`.
- `npx tsc --watch` is useful while iterating on `glide.ts`.
- In Glide, use `:config_edit` to open the config and `:config_reload` to apply changes.

## Coding Style & Naming Conventions
- Keep edits small and direct, with one action per line where practical.
- Use explicit Glide calls, for example `glide.keymaps.set("normal", "<leader>r", "config_reload")`.
- Prefer callbacks only when a mapping needs logic, such as `() => glide.hints.show()`.
- Use clear, descriptive names and avoid adding runtime imports; config is type-stripped before execution.

## Testing Guidelines
- There is no separate test suite in this repository.
- Treat `npm run tsc` as the primary validation step.
- After changing behavior in `glide.ts`, reload Glide and verify the affected key bindings or commands manually.

## Commit & Pull Request Guidelines
- No commit convention is enforced by repository history; use concise imperative messages like `Add tab navigation keymaps`.
- Pull requests should describe the config change, list affected files, and note any manual verification.
- Include screenshots only for UI-facing changes.

## Security & Configuration Tips
- Avoid committing personal browsing data, session files, or other sensitive artifacts under `glide/`.
- When adding new config, prefer minimal reviewable edits so reload regressions are easy to isolate.
