return {
    'Civitasv/cmake-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opt = {
        cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMNADS=1' },
        cmake_build_options = { '-j' },
        cmake_build_directory = "build",
        cmake_dap_configuration = {
            name = "cpp",
            type = "codelldb",
            request = "launch",
            stopOnEntry = false,
            runInTerminal = true,
            console = "integratedTerminal"
        },
        cmake_executor = {
            name = "quickfix",
            opts = {
                show = "always",
                position = "belowright",
                size = 8,
                encoding = "utf-8",
                auto_close_when_success = true
            }
        },
        cmake_runner = {
            name = "terminal",
            opts = {
                name = "Main Terminal",
                prefix_name = "[CMakeTools]: ",
                split_direction = "horizonal",
                split_size = 8
            }
        },
        cmake_notifications = {
            runner = { enabled = true },
            executor = { enabled = true },
            spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
            refresh_rate_ms = 100, -- how often to iterate icons
        },
        cmake_virtual_text_support = true
    }
}
