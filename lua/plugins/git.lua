return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Load only when opening a file
  opts = {
    -- Appearance customization
    signs = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    
    current_line_blame = true, -- Shows git blame inline as virtual text!
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- Put the blame at the end of the line
      delay = 500,           -- 0.5 second delay before showing blame
    },

    -- Keymaps setup via the on_attach hook
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation between changes (Hunks)
      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end, { desc = "Next Git Hunk" })

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end, { desc = "Previous Git Hunk" })

      -- Actions (Staging, Resetting, Blame)
      map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git Stage Hunk" })
      map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git Reset Hunk" })
      map("v", "<leader>hs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git Stage Visual Lines" })
      map("v", "<leader>hr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git Reset Visual Lines" })
      map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git Stage Entire File" })
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Git Undo Stage Hunk" })
      map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git Reset Entire File" })
      map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git Preview Hunk Popup" })
      map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end, { desc = "Git Detailed Blame Line" })
      map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git Diff Against Index" })
    end,
  },
}
