return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- This pcall checks if the plugin is actually downloaded. 
      -- If it's not downloaded yet, it will fail silently instead of throwing a big error screen.
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end

      configs.setup({
        ensure_installed = { 
          "lua", "vim", "vimdoc", "query", 
          "python", "javascript", "typescript", "html", "css", "json" 
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}
