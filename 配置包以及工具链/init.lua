--[[ 图形标头
╔══╗─╔══╗╔══╗╔══╗╔══╗
║╔╗║─║╔╗║║╔═╝╚╗╔╝║╔═╝
║╚╝╚╗║╚╝║║╚═╗─║║─║║──
║╔═╗║║╔╗║╚═╗║─║║─║║──
║╚═╝║║║║║╔═╝║╔╝╚╗║╚═╗
╚═══╝╚╝╚╝╚══╝╚══╝╚══╝
]]

-- 基础设置
vim.opt.tabstop = 4 -- 设置 Tab 为 4 个空格宽度
vim.opt.shiftwidth = 4 -- 设置自动缩进为 4 个空格
vim.opt.expandtab = true -- 用空格代替 Tab
vim.opt.undofile = false -- 禁用临时文件
vim.opt.backup = false -- 禁用备份文件
vim.opt.swapfile = false -- 禁用交换文件
vim.wo.number = true -- 显示行号
vim.opt.wrap = false -- 取消自动换行
-- vim.opt.list = true -- 将空格显示为·
-- vim.opt.listchars:append("space:·")

-- 剪切到系统剪贴板
vim.api.nvim_set_keymap("v", "<C-x>", '"+x', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })


-- 设置 Lazy.nvim 的安装路径
local lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"

-- 检查 Lazy.nvim 是否存在并克隆
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

-- 确保路径分隔符统一为正斜杠
vim.opt.rtp:prepend(lazypath:gsub("\\", "/"))

vim.cmd([[
	command! CF r C:\Users\asus\template.cpp
]])

-- 使用 Lazy.nvim 安装插件
require("lazy").setup({
    -- 依赖插件 plenary.nvim
{
    "nvim-lua/plenary.nvim",
    lazy = true, -- 可以设置为懒加载，null-ls 会自动加载它
},

    -- 状态栏插件 (lualine)
    {
        "nvim-lualine/lualine.nvim",
        lazy = false, -- 始终加载
        config = function()
            require("lualine").setup({
                options = {
                    -- theme = "tokyonight",
                    theme = "auto",
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

    
-- LSP 配置 (lspconfig)
{
    "neovim/nvim-lspconfig",
    lazy = false, -- 启动时加载
    config = function()
        require("lspconfig").clangd.setup({
            cmd = { "clangd", "--header-insertion=never" },
        })

        -- 配置诊断的显示方式
        vim.diagnostic.config({
            signs = false, -- 禁用左侧标记（包括 E）
            update_in_insert = false, -- 不在插入模式更新诊断
            underline = true, -- 保持下划线提示
            severity_sort = true, -- 根据严重性排序诊断
        })
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
            -- 设置快捷键
        vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
        end,
    },
-- 自动格式化插件配置
{
    "jose-elias-alvarez/null-ls.nvim",
        lazy = false,
        config = function()
            require("null-ls").setup({
        sources = {
            require("null-ls").builtins.formatting.clang_format,
        },
    })
    end,
    }
})




--vim.cmd([[set background=light]]) --设置为浅色背景

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
vim.cmd("highlight Normal guibg=NONE")

-- 自动格式化配置
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})


