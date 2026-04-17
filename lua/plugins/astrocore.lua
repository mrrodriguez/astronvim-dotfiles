---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = true, virtual_lines = false },
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        modeline = false,
      },
      g = {
      },
    },
    mappings = {
      n = {
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        -- Custom Python Runner
        ["<Leader>rp"] = {
          function()
            vim.cmd "silent! w"
            local file = vim.fn.expand "%"
            local cmd = string.format("python %s", file)
            require("astrocore").toggle_term_cmd { cmd = cmd, direction = "float" }
          end,
          desc = "Save and run current Python file",
        },
        -- Copy file paths to clipboard
        ["<Leader>yp"] = {
          function()
            local filepath = vim.api.nvim_buf_get_name(0)
            if filepath == "" then
              vim.notify("Buffer has no file path", vim.log.levels.WARN)
              return
            end
            filepath = vim.fn.fnamemodify(filepath, ":p")
            vim.fn.setreg("+", filepath)
            vim.notify("Copied: " .. filepath, vim.log.levels.INFO)
          end,
          desc = "Copy absolute file path",
        },
        ["<Leader>yr"] = {
          function()
            local filepath = vim.api.nvim_buf_get_name(0)
            if filepath == "" then
              vim.notify("Buffer has no file path", vim.log.levels.WARN)
              return
            end
            filepath = vim.fn.fnamemodify(filepath, ":p")
            local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
            if vim.v.shell_error ~= 0 then
              vim.notify("Not in a git repository", vim.log.levels.WARN)
              return
            end
            local rel_path = filepath:sub(#git_root + 2)
            vim.fn.setreg("+", rel_path)
            vim.notify("Copied (git-relative): " .. rel_path, vim.log.levels.INFO)
          end,
          desc = "Copy git-relative file path",
        },
        ["<Leader>yR"] = {
          function()
            local filepath = vim.api.nvim_buf_get_name(0)
            if filepath == "" then
              vim.notify("Buffer has no file path", vim.log.levels.WARN)
              return
            end
            filepath = vim.fn.fnamemodify(filepath, ":p")
            local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
            if vim.v.shell_error ~= 0 then
              vim.notify("Not in a git repository", vim.log.levels.WARN)
              return
            end
            local root_name = vim.fn.fnamemodify(git_root, ":t")
            local rel_path = filepath:sub(#git_root + 2)
            local path_with_root = root_name .. "/" .. rel_path
            vim.fn.setreg("+", path_with_root)
            vim.notify("Copied (with root): " .. path_with_root, vim.log.levels.INFO)
          end,
          desc = "Copy git-relative path (including root)",
        },
      },
      t = {
        ["jk"] = { "<C-\\><C-n>", desc = "Exit terminal mode" },
      },
    },
  },
}
