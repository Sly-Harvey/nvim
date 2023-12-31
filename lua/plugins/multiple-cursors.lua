return {
    "brenton-leighton/multiple-cursors.nvim",
    opts = {
        enable_split_paste = true,
        match_visible_only = false,
    },
    keys = {
        {"<CA-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = {"n", "i"}},
        {"<CA-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = {"n", "i"}},
        {"<CA-j>", "<Cmd>MultipleCursorsAddDown<CR>"},
        {"<CA-k>", "<Cmd>MultipleCursorsAddUp<CR>"},
        {"<CA-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = {"n", "i"}},
        {"<Leader>a", "<Cmd>MultipleCursorsAddToWordUnderCursor<CR>", mode = {"n", "v"}},
    },
}
