return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Go to left window" },
    { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Go to lower window" },
    { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Go to upper window" },
    { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Go to right window" },
  },
}
