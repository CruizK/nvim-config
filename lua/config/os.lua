local os = {
  iswin32 = vim.fn.has("win32") == 1,
  iswsl = vim.fn.has("wsl") == 1
}

return os
