vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- inc/dec
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit window [v]ertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit window [h]orizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make [s]plit [e]qual size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current [s]plit [x]" })

-- buffers
keymap.set("n", "tk", ":blast<enter>", { desc = "Last buffer" })
keymap.set("n", "tj", ":bfirst<enter>", { desc = "First buffer" })
keymap.set("n", "th", ":bprev<enter>", { desc = "Previous buffer" })
keymap.set("n", "tl", ":bnext<enter>", { desc = "Next buffer" })
keymap.set("n", "td", ":bdelete<enter>", { desc = "Delete buffer" })
-- Save file
keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Close a file" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save a file" })

-- Moving within file
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up with coursor in center" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down with coursor in center" })

--
keymap.set("v", "<leader>p", '"_dP', { desc = "Overwrite, do not copy underlying data", noremap = true })
