vim.g.mapleader = " "

-- Parent View (While in normal mode, when pressing leader pv)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Disable arrow keys
vim.keymap.set({"n","v","i"}, "<up>", "<nop>")
vim.keymap.set({"n","v","i"}, "<down>", "<nop>")
vim.keymap.set({"n","v","i"}, "<left>", "<nop>") 
vim.keymap.set({"n","v","i"}, "<right>", "<nop>")

-- Split
vim.keymap.set({"n", "v"}, "<C-w><C-v>", "<C-w>s")

-- Split resizing
vim.keymap.set({"n", "v"}, "<C-w><C-l>", "10<C-w>>")
vim.keymap.set({"n", "v"}, "<C-w><C-h>", "10<C-w><")
vim.keymap.set({"n", "v"}, "<C-w><C-j>", "10<C-w>-")
vim.keymap.set({"n", "v"}, "<C-w><C-k>", "10<C-w>+")

-- Move lines up/down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv")
-- disabled because of vim-tmux-navigator
-- vim.keymap.set("n", "<C-k>", ":m .-2<CR>==")
-- vim.keymap.set("n", "<C-j>", ":m .+1<CR>==")

-- Navigation in insert mode
vim.keymap.set("i", "<C-k>", "<up>")
vim.keymap.set("i", "<C-h>", "<left>")
vim.keymap.set("i", "<C-j>", "<down>")
vim.keymap.set("i", "<C-l>", "<right>")

-- Keep cursor when appending
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Keep cursor in the middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Quick fix navigation
-- TODO vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- TODO vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Navigate between windows
vim.keymap.set("n", "<leader>l", "<Esc><C-w>l")
vim.keymap.set("n", "<leader>h", "<Esc><C-w>h")
vim.keymap.set("n", "<leader>k", "<Esc><C-w>k")
vim.keymap.set("n", "<leader>j", "<Esc><C-w>j")


-- Remap lsp keys
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", {remap = true})


-- Start replacing selected word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
