return
--- @type LazySpec
{
    {
        "pwntester/octo.nvim",
        cmd = "Octo",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            picker = "snacks",
            enable_builtin = true,
        },
        keys = {
            { "<leader>gi", "<cmd>Octo issue list<CR>", desc = "List issues" },
            { "<leader>gp", "<cmd>Octo pr list<CR>", desc = "List PRs" },
            { "<leader>gP", "<cmd>Octo pr<CR>", desc = "Current branch PR" },
            { "<leader>gc", "<cmd>Octo pr checks<CR>", desc = "PR CI checks" },
            { "<leader>gr", "<cmd>Octo review start<CR>", desc = "Start PR review" },
            { "<leader>gR", "<cmd>Octo review resume<CR>", desc = "Resume PR review" },
            { "<leader>gs", "<cmd>Octo search<CR>", desc = "Search GitHub" },
        },
    },
}
