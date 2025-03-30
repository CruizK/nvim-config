local M = {}

---@type boolean
M.is_windows = vim.uv.os_uname().version:match("Windows")

---@type string
M.sep = M.is_windows and "\\" or "/"

---@param filepath string
---@return boolean
M.exists = function(filepath)
  local stat = vim.uv.fs_stat(filepath)
  return stat ~= nil and stat.type ~= nil
end

--- Returns the path up to the folder optional integer depth
---@param filepath string
---@param folder string
---@param depth ?integer
---@return ?string
M.get_path_up_to = function(filepath, folder, depth)
  local depth = depth or 0
  local parts = vim.split(filepath, M.sep)
  local cur_parts = {}
  local up_to_x = 0

  if vim.tbl_contains(parts, folder) == false then
    return nil
  end

  for _, part in ipairs(parts) do
    up_to_x = up_to_x + 1
    if folder == part then
      break
    end
  end

  if up_to_x + depth > #parts then
    return nil
  end

  for i = 1, up_to_x + depth do
    table.insert(cur_parts, parts[i])
  end
  return table.concat(cur_parts, M.sep)
end

--- Returns the git root of cwd
--- @param filepath string
--- @return string
M.get_git_root = function(filepath)
  vim.fn.chdir(filepath)
  return vim.fn.system({ 'git', 'rev-parse', '--show-toplevel' })
end

--- print(M.get_path_up_to("/home/cruizk/dev/de.transformer/main/projects", "weewee"))

return M
