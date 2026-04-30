return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "cue" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local nvim_lsp = require("lspconfig")

      opts.diagnostics.virtual_text = false

      -- disable this for the time being, annoying lints
      -- opts.servers.marksman.init_options.markdownlint = false

      opts.servers.cue_lsp = {
        mason = false,
        cmd = { "cue", "lsp" },
        filetypes = { "cue" },
      }

      vim.filetype.add({ extension = { k = "kcl" } })

      opts.servers.kcl = {}

      -- use nixd over nil_ls, disblaes mason from fetching nil_ls
      opts.servers.nil_ls = {
        enabled = false,
      }

      opts.servers.nixd = {
        -- disable Mason and get nixd as a nixpkg, Mason has trouble linking it on Darwin
        mason = false,
        settings = {
          nixd = {
            formatting = {
              command = { "nixfmt" },
            },
            nixpkgs = {
              expr = 'import (builtins.getFlake "/home/hsyed/.dotfiles").inputs.nixpkgs { }',
            },
            options = {
              nixos = {
                expr = '(builtins.getFlake "/home/hsyed/.dotfiles").nixosConfigurations.catharsis.options',
              },
              darwin = {
                expr = '(builtins.getFlake "/home/hsyed/.dotfiles").darwinConfigurations.personal.options',
              },
              home_personal = {
                expr = '(builtins.getFlake "/home/hsyed/.dotfiles").homeConfigurations."hsyed@personal".options',
              },
              home_catharsis = {
                expr = '(builtins.getFlake "/home/hsyed/.dotfiles").homeConfigurations."hsyed@catharsis".options',
              },
            },
          },
        },
      }

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
