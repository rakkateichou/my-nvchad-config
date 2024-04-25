require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.autochdir = true

vim.g.nvim_tree_respect_buf_cwd = 1

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.cmd[[ "aunmenu PopUp.How-to\ disable\ mouse" ]]
vim.cmd[[ "aunmenu PopUp.-1-" ]]

local _, nvimtree = pcall(require, "nvim-tree")

nvimtree.setup({
  git = {
    ignore = false,
  },
})
