local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },

    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
  },

  format_on_save = function(bufnr)
    -- keep it simple; you can tune timeouts per your machine later
    return { timeout_ms = 2000, lsp_fallback = true, bufnr = bufnr }
  end,
})
