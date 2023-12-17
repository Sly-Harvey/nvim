return {
    'numToStr/Comment.nvim',
    opts = {
        toggler = {
            ---Line-comment toggle keymap
            line = 'cl',
            ---Block-comment toggle keymap
            block = 'cb',
        }, -- add any options here
        opleader = {
            ---Line-comment keymap
            line = 'cl',
            ---Block-comment keymap
            block = 'cb',
        },
        extra = {
            ---Add comment on the line above
            above = 'clO',
            ---Add comment on the line below
            below = 'clo',
            ---Add comment at the end of line
            eol = 'cla',
        },
    },
    lazy = false,
}
