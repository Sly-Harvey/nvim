return {
    "brenton-leighton/multiple-cursors.nvim",
    opts = {
        enable_split_paste = true,
        match_visible_only = false,
    },
    keys = {
        {"<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i"}},
        {"<C-j>", "<Cmd>MultipleCursorsAddDown<CR>"},
        {"<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i"}},
        {"<C-k>", "<Cmd>MultipleCursorsAddUp<CR>"},
        {"<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}},
        {"<Leader>a", "<Cmd>MultipleCursorsAddToWordUnderCursor<CR>", mode = {"n", "v"}},
    },
}
