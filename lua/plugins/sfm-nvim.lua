require("sfm").setup {
  view = {
    side = "left", -- side of the tree, can be `left`, `right`. this setting will be ignored if view.float.enable is set to true,
    width = 30, -- this setting will be ignored if view.float.enable is set to true,
    float = {
      enable = false,
      config = {
        relative = "editor",
        border = "rounded",
        width = 30, -- int or function
        height = 30, -- int or function
        row = 1, -- int or function
        col = 1 -- int or function
      }
    },
    selection_render_method = "icon" -- render method of selected entries, can be `icon`, `sign`, `highlight`.
  },
  mappings = {
    custom_only = false,
    list = {
      -- user mappings go here
    }
  },
  renderer = {
    icons = {
      file = {
        default = "",
        symlink = "",
      },
      folder = {
        default = "",
        open = "",
        symlink = "",
        symlink_open = "",
      },
      indicator = {
        folder_closed = "",
        folder_open = "",
        file = " ",
      },
      selection = "",
    }
  },
  file_nesting = {
    enabled = true, -- controls whether file nesting is enabled
    expand = true, -- controls whether nested files are expanded by default
    patterns = {
      { "*.cs", { "$(capture).*.cs" } },
      { "*.ts", { "$(capture).js", "$(capture).d.ts.map", "$(capture).*.ts", "$(capture)_*.js", "$(capture)_*.ts" } },
      { "go.mod", { "go.sum" } },
    }, -- controls how files get nested
  },
  misc = {
    trash_cmd = nil,
    system_open_cmd = nil,
  },
}

vim.keymap.set('n', '<leader>e', ':SFMToggle<CR>')
