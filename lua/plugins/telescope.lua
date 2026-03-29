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
        "--no-ignore-vcs",
        "--glob=!.git/",
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        -- Still ignore .git internals but show git-ignored files
        find_command = { "rg", "--files", "--hidden", "--no-ignore-vcs", "--glob=!.git/" },
      },
    },
  },
}
