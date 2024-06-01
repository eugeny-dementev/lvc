-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false
vim.opt.swapfile = false
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.opt.spelloptions = "camel"

if vim.fn.has("win32") == 1 and vim.fn.has("ws1") == 0 then
  vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"

  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end
