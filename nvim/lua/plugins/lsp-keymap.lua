return
--- @type LazySpec
{
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
        -- ===== LSP 能力设置 =====
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        -- 阻止 LSP attach 到虚拟 buffer（nofile、zipfile 等）
        local function bufname_valid(bufname)
            if bufname:match("^[/\\]") or bufname:match("^[a-zA-Z]:") then
                return true
            end
            if bufname:match("^zipfile://") or bufname:match("^tarfile:") then
                return true
            end
            return false
        end

        -- ===== 原生 LSP 快捷键 =====
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local buf = args.buf

                -- 虚拟 buffer 不 attach
                local buftype = vim.bo[buf].buftype
                if buftype == "nofile" then
                    vim.schedule(function()
                        pcall(vim.lsp.buf_detach_client, buf, args.data.client_id)
                    end)
                    return
                end
                local bufname = vim.api.nvim_buf_get_name(buf)
                if #bufname > 0 and not bufname_valid(bufname) then
                    vim.schedule(function()
                        pcall(vim.lsp.buf_detach_client, buf, args.data.client_id)
                    end)
                    return
                end

                -- 原生 LSP keymaps
                local map = function(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
                end

                map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")

                -- Hover（优先 ufo peek，再显示 hover 浮窗）
                map("n", "K", function()
                    local winid = require("ufo").peekFoldedLinesUnderCursor()
                    if not winid then
                        vim.lsp.buf.hover()
                    end
                end, "Hover information")

                map("n", "<leader>gd", vim.lsp.buf.definition, "Go to definition")
                map("n", "<leader>gD", vim.lsp.buf.declaration, "Go to declaration")
                map("n", "<leader>gi", vim.lsp.buf.implementation, "Go to implementation")
                map("n", "<leader>gr", vim.lsp.buf.references, "Find references")
                map("n", "<leader>gy", vim.lsp.buf.type_definition, "Go to type definition")

                map("n", "<leader>gk", vim.diagnostic.goto_prev, "Previous diagnostic")
                map("n", "<leader>gj", vim.diagnostic.goto_next, "Next diagnostic")

                -- 调用层级
                map("n", "<leader>gh", function()
                    vim.lsp.buf.incoming_calls()
                end, "Call hierarchy (callers)")
                map("n", "<leader>gl", function()
                    vim.lsp.buf.outgoing_calls()
                end, "Call hierarchy (callees)")

                -- 签名帮助（InsertEnter 时自动触发）
                vim.api.nvim_create_autocmd("InsertEnter", {
                    buffer = buf,
                    callback = function()
                        local trigger = vim.lsp.buf.signature_help
                        local clients = vim.lsp.get_clients({ bufnr = buf })
                        for _, client in ipairs(clients) do
                            if client.server_capabilities.signatureHelpProvider then
                                trigger()
                                break
                            end
                        end
                    end,
                })

                -- 启用 inlay hints
                vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            end,
        })

        require("mason").setup()

        -- 安装 Mason CLI 工具（格式化、lint 等）
        local mason_tools = {
            "goimports",
            "goimports-reviser",
            "golangci-lint",
            "prettierd",
            "shfmt",
            "clang-format",
            "ast-grep",
            "golines",
            "delve",
            "gofumpt",
            "stylua",
            "yapf",
            "yamlfmt",
            "sleek",
            "shellcheck",
            "hadolint",
            "actionlint",
        }
        local registry = require("mason-registry")
        registry.refresh(function()
            for _, pkg_name in ipairs(mason_tools) do
                local ok, pkg = pcall(registry.get_package, pkg_name)
                if ok and not pkg:is_installed() then
                    vim.schedule(function()
                        vim.notify("Mason: installing " .. pkg_name, vim.log.levels.INFO)
                    end)
                    pkg:install()
                end
            end
        end)

        -- LSP 服务器安装与自动启用
        local lsp_servers = {
            "gopls",
            "basedpyright",
            "vtsls",
            "lua_ls",
            "buf_ls",
            "dockerls",
            "protols",
            "clangd",
            "cssls",
            "html",
            "rust_analyzer",
            "yamlls",
            "markdown_oxide",
            "zls",
            "typos_lsp",
        }
        require("mason-lspconfig").setup({
            ensure_installed = lsp_servers,
            automatic_enable = true,
        })
    end,
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
}
