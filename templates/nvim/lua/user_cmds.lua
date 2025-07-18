-- Autocmds
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 'n', 'j', ':cn<CR>zz<C-w>j', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, 'n', 'k', ':cp<CR>zz<C-w>j', { noremap = true, silent = true })
    end,
})
vim.api.nvim_create_user_command("Sig", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local quickfix_entries = {}
  local in_signature = false
  local current_signature = ""
  local start_line = 0

  for i, line in ipairs(lines) do
    if line:match("^%s*def%s+[%w_]+%s*%(") then
      in_signature = true
      current_signature = line
      start_line = i
    elseif in_signature then
      current_signature = current_signature .. " " .. line
      if line:find("%):") then
        table.insert(quickfix_entries, {
          bufnr = vim.api.nvim_get_current_buf(),
          lnum = start_line,
          col = 1,
          text = current_signature:gsub("^%s*", "")
        })
        in_signature = false
        current_signature = ""
      end
    end
  end

  vim.fn.setqflist(quickfix_entries, 'r')
  vim.cmd("copen")
end, { desc = "Extract Python function signatures into a new buffer" })

vim.api.nvim_create_user_command("Clean", function(opts)
    local start_line, end_line

    if opts.range == 2 then
        -- Range was provided
        start_line = opts.line1 - 1  -- Convert to 0-based indexing
        end_line = opts.line2
    else
        -- No range, operate on entire buffer
        start_line = 0
        end_line = -1
    end

    local lines = vim.api.nvim_buf_get_lines(0, start_line, end_line, false)
    local filtered_lines = {}

    for _, line in ipairs(lines) do
        -- Remove Windows line endings (^M / \r)
        line = line:gsub("\r", "")

        -- Keep line if it contains non-whitespace characters OR if it's completely empty
        if line:match("%S") or line == "" then
            table.insert(filtered_lines, line)
        end
    end

    -- Replace the specified range with filtered lines
    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, filtered_lines)
end, {
    range = true,  -- Enable range support
    desc = "Remove whitespace-only lines, keeping empty lines and removing Windows line endings"
})
