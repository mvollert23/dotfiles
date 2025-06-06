-- vim.opt.clipboard = 'unnamedplus' -- use system keyboard for yank
 
vim.opt.nu = true                 -- set line numbers -- set line numbers
vim.opt.relativenumber = true     -- use relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.list = true
vim.opt.listchars = { trail = '@', tab = '>~' }

vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

    -- see below for full list of options 👇
vim.opt.statusline="%<%f | %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\\ %P"


-- Show special characters (required to get obsidian pluging to work correctly, see https://github.com/epwalsh/obsidian.nvim/issues/286)
vim.opt.conceallevel = 2
