return {
    {
        "mfussenegger/nvim-dap",
        recommended = true,
        -- desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            -- virtual text for the debugger
        },

        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
            { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
        },
        config = function()
            require("dap-python")

            require("dap.ext.vscode")
            -- local json = require("plenary.json")
            -- vscode.json_decode = function(str)
            --     return vim.json.decode(json.json_strip_comments(str))
            -- end
        end,
        opts = function()
            local dap = require("dap")
            if not dap.adapters["codelldb"] then
                require("dap").adapters["codelldb"] = {
                    type = "server",
                    host = "localhost",
                    port = "${port}",
                    executable = {
                        command = "codelldb",
                        args = {
                            "--port",
                            "${port}",
                        }
                    }

                }
            end
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
        },
        config = function ()
            require("nvim-dap-virtual-text").setup()
        end
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            local dap_python = require('dap-python')
            dap_python.test_runner = "pytest"

            -- local path = "/home/damade2u/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            local path = "C:\\Users\\damil\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\bin\\python.exe"
            dap_python.setup(path)

        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            'williamboman/mason.nvim',
            "mfussenegger/nvim-dap",
        },
        ensure_installed = {"python", "codelldb"}
    },
    {
        "nvim-neotest/nvim-nio"
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap",
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
            { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
        },
        opts = {},
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
}
