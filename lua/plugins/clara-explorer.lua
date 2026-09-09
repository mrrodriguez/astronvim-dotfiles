local clara_root = vim.env.CLARA_RULES_EXPLORER_HOME

local plugins = {
  "Olical/conjure",
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "clojure" } } },
}

if clara_root then
  plugins[#plugins + 1] = {
    dir = clara_root .. "/editor/neovim",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "clojure",
        callback = function(args)
          vim.keymap.set(
            "n",
            "gp",
            "<Cmd>ClaraExplorerNavigateProducer<CR>",
            { buffer = args.buf, desc = "Navigate to Producer (Clara)" }
          )
          vim.keymap.set(
            "n",
            "gc",
            "<Cmd>ClaraExplorerNavigateConsumer<CR>",
            { buffer = args.buf, desc = "Navigate to Consumer (Clara)" }
          )
        end,
      })
    end,
  }
else
  vim.notify("CLARA_HOME_EXPLORER is not set — clara-explorer not loaded", vim.log.levels.WARN)
end

return plugins
