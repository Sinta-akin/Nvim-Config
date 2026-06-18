return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = { "icon" },

      keymaps = {
        ["<C-c>"] = false,
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["y!"] = "actions.copy_entry_path",
      },

      skip_confirm_for_simple_edits = true,

      view_options = {
        show_hidden = true,
      },

      win_options = {
        concealcursor = "ncv",
        conceallevel = 3,
        cursorcolumn = false,
        foldcolumn = "0",
        list = false,
        signcolumn = "no",
        spell = false,
        wrap = false,
      },
    })

    -- 🔁 Toggle Oil (same as your Nix config)
    vim.keymap.set("n", "<leader>e", function()
      if vim.bo.filetype == "oil" then
        vim.cmd("b#")
      else
        vim.cmd("Oil")
      end
    end, { desc = "Toggle oil file explorer" })
  end,
}
