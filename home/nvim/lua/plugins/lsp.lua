return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local nvim_lsp = require("lspconfig")

      opts.diagnostics.virtual_text = false

      -- disable this for the time being, annoying lints
      -- opts.servers.marksman.init_options.markdownlint = false

      -- disable nil and get it as a nixpkg, mason has trouble linking it on Darwin
      opts.servers.nil_ls = { mason = false }

      nvim_lsp.denols.setup({
        on_attach = on_attach,
        root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
      })

      nvim_lsp.ts_ls.setup({
        on_attach = on_attach,
        root_dir = nvim_lsp.util.root_pattern("package.json"),
        single_file_support = false,
      })
    end,
  },
}
