-- disable semantic tokens
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});

require("core.lazy")
require("core.options")
require("core.keymaps")
-- No init file: require("themes")
-- No init file: require("plugins")
