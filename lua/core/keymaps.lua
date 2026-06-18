local map = vim.keymap.set 
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end 


map("n", "<leader>w", ":w<CR>",opts("Save"))
map("n", "<leader>q", ":q<CR>",opts("Quit"))
map("n", "<leader>qq", ":q!<CR>",opts("Quit"))


