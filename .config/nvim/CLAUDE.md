# LazyVim Configuration

## Environment
- **Distribution**: LazyVim (based on lazy.nvim plugin manager)
- **Config Location**: `~/.config/nvim/`
- **Plugin Manager**: lazy.nvim (automatically handles plugin installation/updates)
- **Leader Key**: `<Space>`

## Directory Structure
- `init.lua`: Main entry point, loads LazyVim
- `lua/config/`: Core configuration files
  - `autocmds.lua`: Auto commands
  - `keymaps.lua`: Custom key mappings
  - `lazy.lua`: Lazy.nvim bootstrap and setup
  - `options.lua`: Vim options and settings
- `lua/plugins/`: Plugin configurations (each file = plugin spec)
- `lua/plugins/disabled.lua`: Disable default LazyVim plugins
- `stylua.toml`: Lua formatter configuration

## LazyVim Plugin System
- Each `.lua` file in `lua/plugins/` is automatically loaded
- Plugin specs use lazy.nvim format: `{ "author/plugin-name", opts = {} }`
- LazyVim provides sensible defaults, only override what you need
- Use `lazy = true` for plugins that should load on-demand
- Use `event`, `ft`, `cmd`, or `keys` for lazy loading triggers

## Current Plugin Categories (LazyVim defaults)
- **Editor**: Neo-tree, Telescope, Which-key, Flash
- **LSP**: Mason, nvim-lspconfig, none-ls
- **Completion**: nvim-cmp with various sources
- **Treesitter**: Syntax highlighting and text objects
- **Git**: Gitsigns, LazyGit integration
- **UI**: Noice, mini.nvim suite, bufferline
- **Coding**: Comment.nvim, surround, autopairs

## Key Mappings Conventions
- Use `<leader>` prefix for main commands
- Use `g` prefix for go-to operations
- Use `]` and `[` for next/previous navigation
- Use `<C-x>` for terminal/system operations
- Document keymaps with `desc = "Description"`

## Plugin Configuration Patterns
### Basic Plugin Addition
```lua
return {
  "author/plugin-name",
  opts = {
    -- plugin options here
  }
}
```

### Complex Plugin Setup
```lua
return {
  "author/plugin-name",
  event = "BufReadPost", -- or ft, cmd, keys
  dependencies = { "other/plugin" },
  opts = function()
    return {
      -- dynamic options
    }
  end,
  config = function(_, opts)
    require("plugin-name").setup(opts)
    -- additional setup
  end,
  keys = {
    { "<leader>xx", "<cmd>PluginCommand<cr>", desc = "Plugin Action" }
  }
}
```

## LSP Configuration
- Use Mason to install language servers: `:Mason`
- LSP configs go in `lua/plugins/lsp.lua` or separate files
- Override default LSP settings in plugin specs
- Use `on_attach` function for LSP-specific keymaps

## Common File Types & Extensions
- Lua: `.lua` files for all configuration
- JSON: For certain config files and LSP settings  
- YAML: For some plugin configurations
- Markdown: For documentation

## Useful LazyVim Commands
- `:Lazy` - Plugin manager interface
- `:LazyHealth` - Check plugin health
- `:LazyExtras` - Browse/install LazyVim extras
- `:Mason` - LSP/formatter/linter installer
- `:ConformInfo` - Check formatter status
- `:LspInfo` - Check LSP status

## Code Style
- Use 2 spaces for indentation
- Prefer `opts = {}` over manual `setup()` calls when possible
- Group related plugins in the same file
- Use descriptive filenames: `colorscheme.lua`, `git.lua`, `editor.lua`
- Keep plugin specs concise, extract complex logic to functions

## Common Plugin Types to Consider
- **Colorschemes**: Theme plugins
- **Language Support**: Specific language tools and LSPs
- **Editor Enhancement**: New motions, text objects, UI improvements
- **Git Tools**: Advanced git integration
- **Terminal**: Terminal integration and management
- **Debugging**: DAP (Debug Adapter Protocol) setup
- **Testing**: Test runners and integration
- **Project Management**: Session management, project switching

## Do Not
- Modify core LazyVim files directly
- Override keymaps that conflict with essential LazyVim bindings
- Install plugins that duplicate existing LazyVim functionality without good reason
- Use heavy plugins that significantly slow down startup
- Forget to specify lazy loading for plugins that don't need immediate loading
- Remove essential dependencies without understanding the impact

## Testing Changes
- Restart Neovim after configuration changes
- Use `:Lazy sync` to update plugins
- Check `:checkhealth` for any issues
- Test new keymaps don't conflict with existing ones
- Verify LSP functionality with `:LspInfo`

## Plugin Research Tips
- Check LazyVim extras first: `:LazyExtras`
- Look for plugins with good documentation and active maintenance
- Consider lazy loading strategy for performance
- Test plugins in a separate branch before committing
- Read plugin README for proper LazyVim integration patterns
