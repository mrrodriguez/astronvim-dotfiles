---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      -- Show hidden files/dirs (dotfiles) in all pickers
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        -- Still ignore .git internals
        find_command = { "rg", "--files", "--hidden", "--glob=!.git/" },
      },
    },
  },
}
