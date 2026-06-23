local ensure_installed = {
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

return
--- @type LazySpec
{
	-- LSP 核心与服务器默认配置
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
		},
		config = function()
			-- 为 nvim-ufo 添加 foldingRange capabilities
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			-- 设置全局 LSP 默认配置
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- 镜像 nvim-lspconfig 的 bufname_valid 逻辑，阻止 LSP attach 到虚拟 buffer
			local function bufname_valid(bufname)
				if bufname:match("^[/\\]") or bufname:match("^[a-zA-Z]:") then
					return true
				end
				if bufname:match("^zipfile://") or bufname:match("^tarfile:") then
					return true
				end
				return false
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					local buftype = vim.bo[event.buf].buftype
					if buftype == "nofile" then
						vim.schedule(function()
							pcall(vim.lsp.buf_detach_client, event.buf, event.data.client_id)
						end)
						return true
					end

					local bufname = vim.api.nvim_buf_get_name(event.buf)
					if #bufname > 0 and not bufname_valid(bufname) then
						vim.schedule(function()
							pcall(vim.lsp.buf_detach_client, event.buf, event.data.client_id)
						end)
						return true
					end

					-- 设置诊断信息
					vim.diagnostic.config({
						virtual_text = {
							spacing = 4,
							-- prefix = '⭕'
						},
						float = { severity_sort = true },
						severity_sort = true,
						signs = {
							text = {
								--     [vim.diagnostic.severity.ERROR] = 'E:',
								--     [vim.diagnostic.severity.WARN] = 'W:',
								--     [vim.diagnostic.severity.INFO] = 'I:',
								--     [vim.diagnostic.severity.HINT] = 'H:',
							},
						},
						underline = true,
					})

					-- 设置快捷键
					vim.keymap.set("n", "gd", function()
						local params = vim.lsp.util.make_position_params(0, "utf-8")
						vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result, _, _)
							if not result or vim.tbl_isempty(result) then
								vim.notify("No definition found", vim.log.levels.INFO)
							else
								require("snacks").picker.lsp_definitions()
							end
						end)
					end, { buf = event.buf, desc = "LSP: Goto Definition" })
					vim.keymap.set("n", "grr", function()
						require("snacks").picker.lsp_references()
					end, { buf = event.buf, desc = "LSP: Goto Reference" })
					vim.keymap.set("n", "gld", function()
						vim.diagnostic.open_float({ source = true })
					end, { buf = event.buf, desc = "LSP: Show Diagnostic" })
					vim.keymap.set(
						"n",
						"gtd",
						(function()
							local diag_status = 1 -- 1 is show; 0 is hide
							return function()
								if diag_status == 1 then
									diag_status = 0
									vim.diagnostic.config({
										underline = false,
										virtual_text = false,
										signs = false,
										update_in_insert = false,
									})
								else
									diag_status = 1
									vim.diagnostic.config({
										underline = true,
										virtual_text = true,
										signs = true,
										update_in_insert = true,
									})
								end
							end
						end)(),
						{ buf = event.buf, desc = "LSP: Toggle Diagnostics" }
					)
				end,
			})

			-- Mason 和 mason-lspconfig 设置
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				automatic_enable = true,
			})
		end,
	},
}
