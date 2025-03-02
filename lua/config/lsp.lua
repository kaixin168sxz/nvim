require('mason').setup({
    ui = {
        icons = {
            package_installed = "󰚃 ",
            package_pending = " ",
            package_uninstalled = " "
        }
    }
})


require('mason-lspconfig').setup({})

-- Set different settings for different languages' LSP.
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP.
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer.
local lspconfig = require("lspconfig")

-- Customized on_attach function.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions.
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	if client.name == "rust_analyzer" then
		-- WARNING: This feature requires Neovim v0.10+
		vim.lsp.inlay_hint.enable()
	end

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({
			async = true,
			-- Predicate used to filter clients. Receives a client as
			-- argument and must return a boolean. Clients matching the
			-- predicate are included.
			filter = function(client)
				-- NOTE: If an LSP contains a formatter, we don't need to use null-ls at all.
				return client.name == "null-ls" or client.name == "hls" or client.name == "rust_analyzer"
			end,
		})
	end, bufopts)
end


lspconfig.lua_ls.setup({
 on_attach=on_attach,
})

-- lspconfig.jedi_language_server.setup({
--  on_attach=on_attach,
-- })

lspconfig.pyright.setup({
 on_attach=on_attach,
 settings = {
     pyright = {
       -- Using Ruff's import organizer
       disableOrganizeImports = true,
     },
     python = {
       analysis = {
         -- Ignore all files for analysis to exclusively use Ruff for linting
         ignore = { '*' },
       },
     },
  },
})

-- lspconfig.pylsp.setup({
--  on_attach=on_attach,
-- })

lspconfig.ruff.setup({
 on_attach=on_attach,
 group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
 callback = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client == nil then
   return
  end
  if client.name == 'ruff' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
 end,
 desc = 'LSP: Disable hover capability from Ruff',
})

lspconfig.clangd.setup({
 on_attach=on_attach,
})


