require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.g.nvim_tree_respect_buf_cwd = 1

vim.opt.autochdir = true

local iswin = vim.fn.has "win32" == 1

if iswin then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-nologo -noprofile -ExecutionPolicy RemoteSigned -command"
  vim.opt.shellxquote = ""
end

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

vim.o.confirm = true
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if
      layout[1] == "leaf"
      and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
      and layout[3] == nil
    then
      vim.cmd "quit"
    end
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.cmd [[ aunmenu PopUp.How-to\ disable\ mouse ]]
vim.cmd [[ aunmenu PopUp.-1- ]]

-- This is your opts table
require("telescope").setup {
  defaults = {
    prompt_prefix = "   ",
  },
}

require("colorizer").setup()

local luasnip = require "luasnip"
luasnip.filetype_set("javascript", { "javascriptreact", "html" })

vim.api.nvim_create_user_command("Q", "quit", {})
