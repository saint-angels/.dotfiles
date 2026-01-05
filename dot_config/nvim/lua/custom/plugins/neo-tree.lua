-- lua/custom/plugins/neo-tree.lua
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- Recommended for icons
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- Basic setup
    require('neo-tree').setup {
      -- You can add minimal configuration options here if needed later
      -- For example, to set the position to the right:
      -- window = {
      --   position = "right"
      -- },
      filesystem = {
        follow_current_file = {
          enabled = true, -- Focus the file in the tree when changing buffers.
        },
      },
    }

    -- Keymap to toggle Neo-tree and reveal the current file
    vim.keymap.set('n', '<leader>.', function()
      require('neo-tree.command').execute { toggle = true, reveal = true, position = 'left' }
    end, { desc = 'Toggle Neo-tree and reveal current file' })
  end,
}

