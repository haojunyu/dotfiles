return
--- @type LazySpec
{
    {
        "askfiy/smart-translate.nvim",
        cmd = { "Translate" },
        dependencies = {
            "askfiy/http.nvim", -- a wrapper implementation of the Python aiohttp library that uses CURL to send requests.
        },
        keys = {
            {
                "tt",
                function()
                    local word = vim.fn.expand("<cword>")
                    if word ~= "" then
                        vim.cmd("Translate " .. word)
                    end
                end,
                mode = "n",
                desc = "Translate word under cursor",
            },
            {
                "tt",
                ":Translate<CR>",
                mode = "v",
                desc = "Translate selection",
            },
        },
        opts = {},
    }
}
