local lsp_formatting = function(bufnr)
  vim.lsp.buf.formatting_sync({ bufnr = bufnr })
end

return function(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = autgroup,
    buffer = bufnr,
    desc = "Auto format on save",
    callback = function()
      lsp_formatting(bufnr)
    end,
  })
end
