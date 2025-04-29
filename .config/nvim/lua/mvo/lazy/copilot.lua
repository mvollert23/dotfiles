return {
    -- ...
  {
    "github/copilot.vim",
    lazy = false,
    config = function() -- Mapping tab is cumbersome
        vim.g.copilot_no_tab_map = true; -- Disable tab mapping
        vim.g.copilot_assume_mapped = true; -- Assume that the mapping is already done
        vim.keymap.set('i', '<C-E>', 'copilot#Accept("\\<CR>")', {
          expr = true,
          replace_keycodes = false
        })
    end
  }
}
