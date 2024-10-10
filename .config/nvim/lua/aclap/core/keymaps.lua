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

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[T]ab: [o]pen new" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "[T]ab: close [x]" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab: [n]ext tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]ab: [p]revious tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "[T]ab: current bu[f]fer in new tab" })

-- Save file
keymap.set("n", "<leader>q", "<cmd>q!<CR>", { desc = "Close a file" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save a file" })

-- Moving within file
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up with coursor in center" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down with coursor in center" })

--
keymap.set("v", "<leader>p", '"_dP', { desc = "Overwrite, do not copy underlying data", noremap = true })
