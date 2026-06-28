// Config docs:
//
//   https://glide-browser.app/config
//
// API reference:
//
//   https://glide-browser.app/api
//
// Default config files can be found here:
//
//   https://github.com/glide-browser/glide/tree/main/src/glide/browser/base/content/plugins
//
// Most default keymappings are defined here:
//
//   https://github.com/glide-browser/glide/blob/main/src/glide/browser/base/content/plugins/keymaps.mts
//
// Try typing `glide.` and see what you can do!

glide.keymaps.set("normal", "<A-j>", "tab_prev");
glide.keymaps.set("normal", "<A-k>", "tab_next");

glide.keymaps.set("normal", "<leader>x", "tab_close");

glide.o.hint_size = "24px";
glide.o.hint_chars = "asdfhjklnpw";
glide.o.which_key_delay = 100;

glide.autocmds.create("ModeChanged", "*", (args) => {
  const style_id = "glide-custom-mode-indicator";
  const fallback = "--glide-fallback-mode";
  // If there is a --current-mode-color var I did not find it but it would make this obsolete :)
  const mode_colors: Record<keyof GlideModes, string> = {
    command: "--glide-mode-command",
    hint: "--glide-mode-hint",
    ignore: "--glide-mode-ignore",
    insert: "--glide-mode-insert",
    normal: "--glide-mode-normal",
    "op-pending": "--glide-mode-op-pending",
    visual: "--glide-mode-visual",
  };
  glide.styles.remove(style_id);
  glide.styles.add(
    `
		#browser {
			border-bottom: 3px solid var(${mode_colors[args.new_mode] ?? fallback})
		}	
	`,
    { id: style_id },
  );
});
