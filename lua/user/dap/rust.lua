local dap = require("dap")

-- Helper function to get the crate name from Cargo.toml or fallback to directory name
local function get_crate_name()
    local cargo_toml_path = vim.fn.getcwd() .. "/Cargo.toml"
    local crate_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t") -- Default to current directory name

    if vim.fn.filereadable(cargo_toml_path) == 1 then
        local file = io.open(cargo_toml_path, "r")
        if file then
            local content = file:read("*a")
            file:close()
            -- Try to find [package] name = "..."
            -- This regex looks for a line starting with 'name' after '[package]'
            local pkg_name_match = string.match(content, '%[package%]%s*\n(?:[^\n]*\n)*?name%s*=%s*"([^"]+)"')
            if pkg_name_match then
                crate_name = pkg_name_match
            else
                -- Fallback for simpler name = "..." if not under [package] explicitly (less common for root Cargo.toml)
                local name_match = string.match(content, '^name%s*=%s*"([^"]+)"')
                if name_match then
                    crate_name = name_match
                end
            end
        end
    end
    return crate_name
end

-- Adapter for codelldb
-- Ensure codelldb is installed and in your PATH:
-- https://github.com/vadimcn/codelldb/releases
dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',                         -- This will be replaced by dap
    executable = {
        command = vim.fn.exepath('codelldb'), -- Path to codelldb executable
        -- args = { "dap", "--port", "${port}" },
        args = { "--port", "${port}" },
    },
    options = {
        initialize_timeout_sec = 20, -- Increased timeout for Rust builds
    },
}

-- Configurations for Rust
dap.configurations.rust = {
    {
        name = "Launch Executable (Cargo Build)",
        type = "codelldb", -- Must match the adapter name defined above
        request = "launch",
        program = function()
            local crate = get_crate_name()
            local program_path = vim.fn.getcwd() .. "/target/debug/" .. crate
            if vim.fn.executable(program_path) == 0 then
                vim.notify(
                    "Executable not found at: " .. program_path ..
                    "\nPlease ensure you have run 'cargo build'. You might need to specify the path manually.",
                    vim.log.levels.WARN
                )
                -- Prompt user if executable is not found
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end
            return program_path
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false, -- Set to true to stop at the program entry point
        sourceLanguages = { 'rust' },
        console = "integratedTerminal",
        showDisassembly = "never",
    },
    {
        name = "Debug Cargo Tests (All in Package)",
        type = "codelldb",
        request = "launch",
        cargo = {
            args = {
                "test",
                "--no-run",     -- Build the test harness but don't run it
                "--package",
                get_crate_name, -- Dynamically get package name
                -- To run all tests (binaries and library) in the package.
                -- Add "--lib" or "--bin <name>" to be more specific if needed.
            },
        },
        -- `program` is often not needed when `cargo` args are used, as codelldb finds the test harness.
        -- args = {}, -- No specific test args, runs all tests built by the cargo command
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        sourceLanguages = { 'rust' },
        console = "integratedTerminal",
        showDisassembly = "never",
    },
    {
        name = "Debug Cargo Tests (from file dir)",
        type = "codelldb",
        request = "launch",
        cargo = {
            args = {
                "test",
                "--no-run", -- Build the test harness but don't run it
                -- "--package",
                -- get_crate_name, -- Dynamically get package name
                -- To run all tests (binaries and library) in the package.
                -- Add "--lib" or "--bin <name>" to be more specific if needed.
            },
        },
        -- `program` is often not needed when `cargo` args are used, as codelldb finds the test harness.
        -- args = {}, -- No specific test args, runs all tests built by the cargo command
        cwd = "${fileDirname}",
        stopOnEntry = false,
        sourceLanguages = { 'rust' },
        console = "integratedTerminal",
        showDisassembly = "never",
    },
    {
        name = "Debug Specific Rust Test",
        type = "codelldb",
        request = "launch",
        cargo = {
            args = {
                "test",
                "--no-run",
                "--package",
                get_crate_name,
                -- Add "--lib" or "--bin <name>" if the test is in a specific target
            },
        },
        args = function()
            -- Prompt the user for the specific test path (e.g., my_module::my_test_function)
            local test_path = vim.fn.input("Enter test path (e.g., module::test_fn): ")
            if test_path ~= "" then
                return { test_path } -- This is passed as an argument to the test harness
            end
            return {}
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        sourceLanguages = { 'rust' },
        console = "integratedTerminal",
        showDisassembly = "never",
    },
    {
        name = "Attach to Process",
        type = "codelldb",
        request = "attach",
        processId = require('dap.utils').pick_process, -- Prompts to select a PID
        cwd = "${workspaceFolder}",
        sourceLanguages = { 'rust' },
        showDisassembly = "never",
    },
}
