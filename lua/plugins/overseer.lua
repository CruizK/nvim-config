return {
  'stevearc/overseer.nvim',
  opts = {},
  config = function()
    local overseer = require('overseer')
    overseer.setup({
      templates = {}
    })

    --- Only setup for wsl
    if require('config.os').iswsl then
      local overseer_config = require('config.plugins.overseer')
      overseer.register_template(
        overseer_config.dbt_tasks()
      )
      overseer.register_template(
        overseer_config.pdm_tasks()
      )
    end

    vim.keymap.set('n', '<leader>osr', '<cmd>OverseerRun<CR>')
    vim.keymap.set('n', '<leader>ost', '<cmd>OverseerToggle<CR>')
  end
}
