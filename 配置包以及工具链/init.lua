--[[
╔══╗─╔══╗╔══╗╔══╗╔══╗
║╔╗║─║╔╗║║╔═╝╚╗╔╝║╔═╝
║╚╝╚╗║╚╝║║╚═╗─║║─║║──
║╔═╗║║╔╗║╚═╗║─║║─║║──
║╚═╝║║║║║╔═╝║╔╝╚╗║╚═╗
╚═══╝╚╝╚╝╚══╝╚══╝╚══╝
]]
--

-- 设置缩进和空格
vim.opt.tabstop = 4 -- 设置 Tab 为 4 个空格宽度
vim.opt.shiftwidth = 4 -- 设置自动缩进为 4 个空格
vim.opt.expandtab = true -- 用空格代替 Tab

-- 文件选项
vim.opt.undofile = false -- 禁用临时文件
vim.opt.backup = false -- 禁用备份文件
vim.opt.swapfile = false -- 禁用交换文件

-- 显示行号
vim.wo.number = true -- 显示绝对行号

-- 剪切到系统剪贴板
vim.api.nvim_set_keymap("v", "<C-x>", '"+x', { noremap = true, silent = true })

-- 可视模式下将 Ctrl+C 复制到系统剪贴板
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- 设置默认目录为 ~/acm
vim.cmd("cd ~/Zvezdy_ACM_Codes") -- 切换工作目录到 ~/acm

-- 定义一个命令来插入 C++ 模板
vim.cmd([[
	command! CPPtemplate r ~/.config/nvim/templates/template.cpp
]])

vim.opt.wrap = false -- 取消自动换行

-- 移动光标上下移动5行
vim.api.nvim_set_keymap("n", "<C-j>", "5j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "5k", { noremap = true, silent = true })

-- 水平移动光标5列
vim.api.nvim_set_keymap("n", "<C-h>", "5h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "6l", { noremap = true, silent = true })

-- 快速注释和取消注释
vim.api.nvim_set_keymap("n", "<C-/>", ":lua ToggleComment()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-/>", ":lua ToggleComment()<CR>", { noremap = true, silent = true })
function ToggleComment()
    local line = vim.fn.getline(".")
    if line:match("^%s*//") then
        vim.cmd("normal! ^xx") -- 取消注释
    else
        vim.cmd("normal! I//") -- 添加注释
    end
end

--[[
╔═══╗╔╗──╔╗╔╗╔═══╗╔══╗╔╗─╔╗╔══╗
║╔═╗║║║──║║║║║╔══╝╚╗╔╝║╚═╝║║╔═╝
║╚═╝║║║──║║║║║║╔═╗─║║─║╔╗─║║╚═╗
║╔══╝║║──║║║║║║╚╗║─║║─║║╚╗║╚═╗║
║║───║╚═╗║╚╝║║╚═╝║╔╝╚╗║║─║║╔═╝║
╚╝───╚══╝╚══╝╚═══╝╚══╝╚╝─╚╝╚══╝
]]
--
-- Lazy.nvim 插件管理器配置
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- 最新稳定版
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- 状态栏插件 (lualine)
    {
        "nvim-lualine/lualine.nvim",
        lazy = false, -- 始终加载
        config = function()
            require("lualine").setup({
                options = {
                    theme = "gruvbox",
                },
            })
        end,
    },

    -- Treesitter 插件
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate", -- 安装时更新解析器
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all", -- 安装所有解析器
                highlight = {
                    enable = true, -- 启用语法高亮
                },
            })
        end,
    },

    -- 主题插件
    "folke/tokyonight.nvim", -- Tokyo Night 主题
    "morhetz/gruvbox", -- Gruvbox 主题
    "Mofiqul/dracula.nvim", -- Dracula 主题
    "shaunsingh/nord.nvim", -- Nord 主题
    "altercation/vim-colors-solarized", -- Solarized 主题
    "olimorris/onedarkpro.nvim", -- One Dark Pro 主题
    "EdenEast/nightfox.nvim", -- Nightfox 主题
    "marko-cerovac/material.nvim", -- Material 主题
    "sainnhe/everforest", -- Everforest 主题
    "NLKNguyen/papercolor-theme", -- PaperColor 主题
    "tanvirtin/monokai.nvim", -- Monokai 主题
    "rakr/vim-one",

    -- 模糊查找插件 (telescope)，延迟加载
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        cmd = { "Telescope" }, -- 当运行 Telescope 命令时加载
        requires = { { "nvim-lua/plenary.nvim" } },
        config = function()
            require("telescope").setup({})
            -- 绑定模糊搜索快捷键
            vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
        end,
    },

    -- LSP 配置 (lspconfig)
    {
        "neovim/nvim-lspconfig",
        lazy = false, -- 启动时加载
        config = function()
            require("lspconfig").clangd.setup({}) -- 你可以配置其他 LSP 服务器
        end,
    },

    -- Git 状态显示 (gitsigns)
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = { "BufRead", "BufNewFile" }, -- 当打开或创建文件时加载
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- 自动补全引擎 (nvim-cmp)
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter", -- 进入插入模式时加载
        requires = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "L3MON4D3/LuaSnip" }, -- 代码片段插件
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                },
            })
        end,
    },

    -- 自动括号补全 (nvim-autopairs)
    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter", -- 在插入模式时加载
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -- 快速运行代码 (vim-quickrun)
    {
        "thinca/vim-quickrun",
        lazy = true,
        cmd = { "QuickRun" }, -- 仅在运行 QuickRun 命令时加载
        config = function()
            vim.api.nvim_set_keymap("n", "<leader>r", ":QuickRun<CR>", { noremap = true, silent = true })
        end,
    },

    -- 启动页插件 (dashboard-nvim)
    {
        "glepnir/dashboard-nvim",
        lazy = true,
        event = "VimEnter", -- 在启动时加载
        config = function()
            require("dashboard").setup({})
        end,
    },

    -- 文件快速跳转 (vim-easymotion)
    {
        "easymotion/vim-easymotion",
        lazy = true,
        event = "BufRead", -- 读取缓冲区时加载
    },

    -- 代码注释插件 (Comment.nvim)
    {
        "numToStr/Comment.nvim",
        lazy = true,
        keys = { "gc", "gcc" }, -- 按下这些快捷键时加载
        config = function()
            require("Comment").setup({})
        end,
    },

    -- 文件树插件 (nvim-tree.lua)
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons
        lazy = false, -- 启动时加载
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                    side = "left",
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
            })
        end,
    },

    -- null-ls.nvim 插件
    {
        "jose-elias-alvarez/null-ls.nvim",
        lazy = false, -- 确保插件在启动时加载
        dependencies = { "nvim-lua/plenary.nvim" }, -- null-ls 依赖 plenary.nvim
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- Prettier 格式化 JavaScript、TypeScript、HTML、CSS
                    null_ls.builtins.formatting.prettier.with({
                        extra_args = { "--tab-width", "4" }, -- 缩进为 4 个空格
                    }),
                    -- Stylua 格式化 Lua
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = { "--indent-type", "Spaces", "--indent-width", "4" }, -- Lua 使用 4 个空格缩进
                    }),
                    -- Clang-Format 格式化 C/C++
                    null_ls.builtins.formatting.clang_format.with({
                        extra_args = { "--style", "file" }, -- 使用 .clang-format 文件中的规则
                    }),
                },

                -- 自动格式化设置
                on_attach = function(client, bufnr)
                    if client.server_capabilities.documentFormattingProvider then
                        vim.api.nvim_clear_autocmds({ group = LspFormatting, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = LspFormatting,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
})

vim.cmd([[set background=light]]) --设置为浅色背景

-- 设置主题（根据你使用的主题更改这里）
-- vim.cmd[[colorscheme tokyonight]] -- Tokyo Night 主题
-- vim.cmd([[colorscheme gruvbox]]) -- Gruvbox 主题
-- vim.cmd([[colorscheme dracula]]) -- Dracula 主题
-- vim.cmd([[colorscheme nord]]) -- Nord 主题
-- vim.cmd([[colorscheme solarized]]) -- Solarized 主题
-- vim.cmd([[colorscheme onedarkpro]]) -- One Dark Pro 主题
-- vim.cmd([[colorscheme nightfox]]) -- Nightfox 主题
-- vim.cmd([[colorscheme catppuccin]]) -- Catppuccin 主题
-- vim.cmd([[colorscheme material]]) -- Material 主题
-- vim.cmd([[colorscheme everforest]]) -- Everforest 主题
-- vim.cmd([[colorscheme PaperColor]]) -- PaperColor 主题
-- vim.cmd([[colorscheme monokai]]) -- Monokai 主题
vim.cmd([[colorscheme one]]) -- 启用 One Light 主题

-- 设置背景为透明
vim.cmd("highlight Normal guibg=NONE")
