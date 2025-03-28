local dap = require("dap")

dap.adapters.go = {
    type = 'server',
    port = '${port}',
    executable = {
        command = vim.fn.exepath('dlv'),
        args = {'dap', '--listen', '127.0.0.1:${port}'},
    },
    options = {
        initialize_timeout_sec = 20,
    },
}

dap.configurations.go = {
    {
        type = 'go',
        name = 'Debug Current File',
        request = 'launch',
        program = "${file}",
        dlvToolPath = vim.fn.exepath('dlv'),
        showLog = true,  -- Enable logging to help debug issues
        console = "integratedTerminal",
        trace = true,    -- Enable trace to get more detailed debug logs
    },
    {
        type = 'go',
        name = 'Debug Package',
        request = 'launch',
        program = "${fileDirname}",
        dlvToolPath = vim.fn.exepath('dlv'),
        showLog = false,
        console = "integratedTerminal",
    },
    {
        type = 'go',
        name = 'Debug Test',
        request = 'launch',
        mode = 'test',
        program = "${file}",
        dlvToolPath = vim.fn.exepath('dlv'),
        showLog = false,
        console = "integratedTerminal",
    },
    {
        type = 'go',
        name = 'Debug Test (go.mod)',
        request = 'launch',
        mode = 'test',
        program = "./${relativeFileDirname}",
        dlvToolPath = vim.fn.exepath('dlv'),
        showLog = false,
        console = "integratedTerminal",
    },
    {
        type = 'go',
        name = 'Attach',
        mode = 'local',
        request = 'attach',
        processId = require('dap.utils').pick_process,
        dlvToolPath = vim.fn.exepath('dlv'),
        showLog = false,
        console = "integratedTerminal",
    },
    {
        type = 'go',
        name = 'Remote Debug',
        mode = 'remote',
        request = 'attach',
        port = function()
            return vim.fn.input('Port: ', '2345')
        end,
        host = function()
            return vim.fn.input('Host: ', '127.0.0.1')
        end,
        dlvToolPath = vim.fn.exepath('dlv'),
        showLog = false,
        console = "integratedTerminal",
    },
}
