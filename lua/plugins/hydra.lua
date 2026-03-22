return {
  "anuvyklack/hydra.nvim",
  event = "VeryLazy",
  config = function()
    local Hydra = require "hydra"
    Hydra {
      name = "Window Management",
      mode = "n",
      body = "<Leader>w",
      config = {
        invoke_on_body = true,
        hint = {
          border = "rounded",
          position = "bottom",
        },
      },
      hint = [[
 ^ ^          Window Management
 ^ ^  ---------------------------
 _h_ _j_ _k_ _l_ : move focus    _d_ : close
 _+_ _-_ _>_ _<_ : resize        _=_ : equalize
 ^ ^              _<Esc>_ : exit
]],
      heads = {
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", "<C-w>k" },
        { "l", "<C-w>l" },
        { "+", "2<C-w>+" },
        { "-", "2<C-w>-" },
        { ">", "5<C-w>>" },
        { "<", "5<C-w><" },
        { "=", "<C-w>=" },
        { "d", "<C-w>c" },
        { "q", nil, { exit = true, desc = "quit" } },
        { "<Esc>", nil, { exit = true } },
      },
    }

    Hydra {
      name = "Smooth Scrolling",
      mode = "n",
      body = "<Leader>s",
      config = {
        invoke_on_body = true,
        hint = {
          border = "rounded",
          position = "bottom",
        },
      },
      hint = [[
 ^ ^          Scrolling
 ^ ^  ---------------------------
 _j_ _k_ : line scroll (3)   _f_ : page down
 _d_ _u_ : half page         _b_ : page up
 _g_ _G_ : top/bottom        _=_ : center cursor
 ^ ^              _<Esc>_ : exit
]],
      heads = {
        { "j", "3<C-e>" },
        { "k", "3<C-y>" },
        { "d", "<C-d>" },
        { "u", "<C-u>" },
        { "f", "<C-f>" },
        { "b", "<C-b>" },
        { "g", "gg" },
        { "G", "G" },
        { "=", "zz" },
        { "q", nil, { exit = true, desc = "quit" } },
        { "<Esc>", nil, { exit = true } },
      },
    }
  end,
}
