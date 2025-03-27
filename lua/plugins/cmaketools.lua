return {
  'Civitasv/cmake-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    cmake_command = 'cmake',
    cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=1' },
    cmake_build_options = { '-j' },
    cmake_build_directory = 'build',
    cmake_variants_message = {
      short = { show = true },
      long = { show = true, max_length = 40 },
    },
    cmake_dap_configuration = {
      name = 'cpp',
      type = 'codelldb',
      request = 'launch',
      stopOnEntry = false,
      runInTerminal = true,
      console = 'integratedTerminal',
    },
    cmake_executor = {
      name = 'quickfix',
      opts = {
        show = 'always',
        position = 'belowright',
        size = 10,
        encoding = 'utf-8',
        auto_close_when_success = true,
      },
    },
    cmake_runner = {
      name = 'quickfix',
      opts = {
        show = 'always',
        position = 'belowright',
        size = 10,
        encoding = 'utf-8',
        auto_close_when_success = true,
      },
    },
    cmake_notifications = {
      runner = { enabled = true },
      executor = { enabled = true },
      spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
      refresh_rate_ms = 100,
    },
  },
}
