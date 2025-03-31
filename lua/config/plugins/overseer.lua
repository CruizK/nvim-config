local M = {}

local files = require("overseer.files")
local utils = require('config.utils')
local root = "/home/cruizk/dev/de.transformer"

--- @param search overseer.SearchCondition
--- @returns boolean
M.in_transformer = function(search)
  return files.is_subpath(root, search.dir)
end

--- @param dir string Any directory inside transformer repo worktree
--- @returns string[]
M.list_projects = function(dir)
  local git_root = utils.get_git_root(dir)
  local projects_root = files.join(git_root, "projects")
  local projects = utils.list_dirs(projects_root)
  return vim.tbl_map(function(project)
    return files.join(projects_root, project)
  end, projects)
end

--- @param search overseer.SearchCondition
--- @param projects string[]
--- @returns boolean
M.in_project_dir = function(search, projects)
  for _, project in ipairs(projects) do
    if files.is_subpath(project, search.dir) then
      return true
    end
  end
  return false
end

M.pdm_tasks = function()
  --- @type overseer.TemplateProvider
  local pdm_template = {
    name = "PDM Template",
    generator = function(search, cb)
      local tasks = {}

      --- @type overseer.TemplateDefinition
      local pdm_sync = {
        name = "PDM Sync",
        builder = function()
          return {
            name = "PDM Sync",
            cmd = "pdm",
            args = { "sync" },
            cwd = search.dir
          }
        end
      }

      table.insert(tasks, pdm_sync)
      cb(tasks)
    end,
    condition = { callback = M.in_transformer }
  }

  return pdm_template
end

M.dbt_tasks = function()
  --- @type overseer.TemplateDefinition|overseer.TemplateProvider
  local dbt_template = {
    name = "DBT Template",
    generator = function(search, cb)
      --- @type overseer.TemplateDefinition[]
      local tasks = {}
      local projects = M.list_projects(search.dir)

      local function condition_cb(task_search)
        return M.in_project_dir(task_search, projects)
      end
      --- @type overseer.TemplateDefinition
      local dbt_run_task = {
        name = "Run DBT Model",
        params = {
          full_refresh = {
            type = "boolean",
            default = false
          },
          select = {
            type = "string",
            name = "Model to run",
            order = 1
          }
        },
        condition = { callback = condition_cb },
        builder = function(params)
          local args = { "dbt", "run", "--select", params.select }
          if params.full_refresh then
            table.insert(args, "-f")
          end
          return {
            name = "DBT Run",
            cmd = { "pdm" },
            args = args,
            cwd = search.dir
          }
        end
      }

      local dbt_sync_task = {
        name = "DBT deps",
        condition = { callback = condition_cb },
        builder = function(_)
          return {
            name = "DBT deps",
            cmd = { "pdm" },
            args = { "dbt", "deps" },
            cwd = search.dir
          }
        end
      }

      table.insert(tasks, dbt_sync_task)
      table.insert(tasks, dbt_run_task)
      cb(tasks)
    end,
    condition = {
      callback = M.in_transformer
    }
  }

  return dbt_template
end

return M
