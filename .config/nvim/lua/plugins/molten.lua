return {
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      style = "quarto",
      output_extension = ".qmd",
      force_ft = "quarto",
    },
    config = true,
  },
  {
    "quarto-dev/quarto-nvim",
    -- ft = { "quarto", "markdown", "ipynb" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = "curly", -- expect ```{python} style chunks
        languages = { "python" },
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = { enabled = true },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten", -- send cells to Molten
        ft_runners = { python = "molten" },
        never_run = { "yaml" },
      },
    },
    config = function(_, opts)
      require("quarto").setup(opts)

      vim.api.nvim_create_autocmd("BufReadPost", {
        pattern = "*.md",
        callback = function(args)
          local has_curly = false
          for i = 1, math.min(200, vim.api.nvim_buf_line_count(args.buf)) do
            local line = vim.api.nvim_buf_get_lines(args.buf, i - 1, i, false)[1]
            if line and line:match("^%s*```%s*{[%w_%-]+") then
              has_curly = true
              break
            end
          end
          if has_curly then
            vim.bo[args.buf].filetype = "quarto"
          end
        end,
      })
      -- Make outputs and inline annotations visible
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "quarto", "markdown" },
        callback = function()
          vim.opt_local.conceallevel = 0
          vim.keymap.set(
            "n",
            "<leader>mc",
            require("quarto").quartoSend,
            { desc = "Run quarto chunk", silent = true, buffer = true }
          )
          vim.keymap.set(
            "n",
            "<leader>ml",
            require("quarto").quartoSendLine,
            { desc = "Run quarto line", silent = true, buffer = true }
          )
        end,
      })
    end,
  },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    ft = { "python", "markdown", "quarto", "ipynb" },
    config = function()
      vim.g.molten_auto_open_output = true
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 200
      vim.g.molten_virt_text_output = true
      vim.g.molten_image_location = "float"
      vim.g.molten_output_win_max_width = 200
      vim.g.molten_output_win_cover_gutter = false
      vim.g.molten_output_win_style = "minimal"
    end,
    keys = {
      {
        "<leader>mi",
        ":MoltenInit<CR>",
        desc = "Initialize Molten",
        ft = { "python", "markdown", "quarto" },
      },
      {
        "<leader>me",
        ":MoltenEvaluateOperator<CR>",
        desc = "Evaluate Operator",
        ft = { "python", "markdown", "quarto" },
      },
      {
        "<leader>ml",
        ":MoltenEvaluateLine<CR>",
        desc = "Evaluate Line",
        ft = { "python", "markdown", "quarto" },
      },
      {
        "<leader>mr",
        ":<C-u>MoltenEvaluateVisual<CR>gv",
        desc = "Evaluate Visual Selection",
        mode = "v",
        ft = { "python", "markdown", "quarto" },
      },
      {
        "<leader>mc",
        ":MoltenReevaluateCell<CR>",
        desc = "Re-evaluate Cell",
        ft = { "python", "markdown", "quarto" },
      },
      {
        "<leader>md",
        ":MoltenDelete<CR>",
        desc = "Delete Cell",
        ft = { "python", "markdown", "quarto" },
      },
      {
        "<leader>mo",
        ":MoltenShowOutput<CR>",
        desc = "Show Output",
        ft = { "python", "markdown", "quarto" },
      },
      {
        "<leader>mh",
        ":MoltenHideOutput<CR>",
        desc = "Hide Output",
        ft = { "python", "markdown", "quarto" },
      },
    },
  },
  {
    "3rd/image.nvim",
    ft = { "markdown", "quarto" },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = true,
          filetypes = { "markdown", "vimwiki" },
        },
      },
      max_width = nil, -- No width limit
      max_height = nil, -- No height limit
      max_width_window_percentage = 90, -- Use 90% of window width
      max_height_window_percentage = 90, -- Use 90% of window height
      kitty_method = "normal",
    },
  },
}
