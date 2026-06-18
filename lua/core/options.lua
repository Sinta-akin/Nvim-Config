-- lua/core/options.lua

-- ======================================================================
-- Neovim Core Options
-- Author: Ayush
-- Description: Clean, professional configuration for Python development
-- ======================================================================

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Short alias
local opt = vim.opt

-- ------------------------------
-- 🧩 UI & Appearance
-- ------------------------------
opt.number = true                -- Show line numbers
opt.relativenumber = true        -- Relative line numbers for easy navigation
opt.cursorline = true            -- Highlight current line
opt.signcolumn = "yes"           -- Always show sign column
opt.termguicolors = true         -- Enable 24-bit RGB colors
opt.scrolloff = 8                -- Keep 8 lines visible above/below cursor
opt.cmdheight = 1                -- Minimal command line height
opt.updatetime = 50              -- Faster diagnostics & CursorHold events

-- ------------------------------
-- 🧱 Indentation & Tabs
-- ------------------------------
opt.tabstop = 4                  -- 4 spaces per tab
opt.shiftwidth = 4               -- Indent by 4 spaces
opt.expandtab = true             -- Convert tabs to spaces
opt.smartindent = true           -- Smart auto-indentation
opt.autoindent = true            -- Copy indent from current line

-- ------------------------------
-- 🔍 Search
-- ------------------------------
opt.ignorecase = true            -- Ignore case in search
opt.smartcase = true             -- Override ignorecase if uppercase used
opt.hlsearch = true              -- Highlight search results
opt.incsearch = true             -- Show matches while typing

-- ------------------------------
-- 🧰 Files & Backups
-- ------------------------------
opt.swapfile = false             -- Disable swap files
opt.backup = false               -- Disable backups
opt.undofile = true              -- Persistent undo
opt.undodir = vim.fn.expand("~/.local/share/nvim/undo") -- Better path for undo files

-- ------------------------------
-- 🖱️ Behavior & Misc
-- ------------------------------
opt.wrap = true                 -- Disable line wrapping
opt.hidden = true                -- Allow background buffers
opt.mouse = "a"                  -- Enable mouse support
opt.clipboard = "unnamedplus"    -- Use system clipboard
opt.encoding = "utf-8"           -- Default encoding
opt.fileencoding = "utf-8"       -- File encoding

-- ------------------------------
-- 🪟 Window Management
-- ------------------------------
-- Resize current split to 2/3 of total screen width
vim.keymap.set("n", "<leader>wr", function()
  local total = vim.o.columns
  vim.cmd("vertical resize " .. math.floor(total * 2 / 3))
end, { desc = "Resize window to 2/3 width" })

-- ======================================================================
-- End of options.lua
-- ======================================================================

