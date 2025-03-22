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
-- vim.g.mapleader = " "
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
	command! CF r C:\Users\24767\template.cpp
]])

-- 使用 Lazy.nvim 安装插件
require("lazy").setup({
	-- 依赖插件 plenary.nvim
	{
		"nvim-lua/plenary.nvim",
		lazy = true, -- 可以设置为懒加载，null-ls 会自动加载它
	},

	-- coverage
	{
		"andythigpen/nvim-coverage",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("coverage").setup({
				auto_reload = true, -- 自动刷新覆盖率
				lang = { -- 按需启用语言支持
					python = true,
					javascript = true,
					go = true,
				},
			})
		end,
	},

	-- 状态栏插件 (lualine)
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "onedark", -- 指定主题
					component_separators = { left = "", right = "" }, -- 更美观的分隔符
					section_separators = { left = "", right = "" },
					-- refresh = { -- 动态刷新策略
					-- 	statusline = 200, -- 每200ms刷新（适合实时信息）
					-- 	tabline = 1000,
					-- 	winbar = 200,
					-- },
				},
				sections = {
					lualine_a = {
						{
							"mode",
							icon = "",
							-- color = { bg = "#FF9E64", fg = "#1A1A1A" }
						}, -- 带图标的模式显示
					},
					lualine_b = {
						"branch",
						{
							"diff",
							symbols = { added = " ", modified = " ", removed = " " }, -- 更直观的diff图标
							-- diff_color = {
							-- 	added = { fg = "#98C379" },
							-- 	modified = { fg = "#E5C07B" },
							-- 	removed = { fg = "#E06C75" },
							-- },
						},
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
							colored = true,
							always_visible = false,
						},
					},
					lualine_c = {
						{
							"filename",
							path = 1, -- 显示相对路径
							symbols = { modified = " ●", readonly = " " },
						},
						{
							"navic", -- 显示代码结构（需安装 nvim-navic）
							color_correction = "static",
							navic_opts = {
								highlight = true,
								depth_limit = 3,
							},
						},
					},
					lualine_x = {
						{
							require("lazy.status").updates, -- 显示插件更新数量（需 lazy.nvim）
							cond = require("lazy.status").has_updates,
							-- color = { fg = "#FF9E64" },
						},
						{
							"encoding",
							fmt = string.upper, -- 显示为 UTF-8
							cond = function()
								return vim.bo.fileencoding ~= ""
							end,
						},
						{
							"fileformat",
							symbols = { unix = "", dos = "", mac = "" },
						},
						{
							"filetype",
							icon_only = true,
							colored = true,
						},
					},
					lualine_y = {
						{
							"progress",
							padding = { left = 1, right = 0 },
							-- color = { fg = "#61AFEF" },
						},
						{
							"location",
							-- color = { fg = "#C678DD" },
						},
					},
				},
				extensions = { "nvim-tree", "toggleterm", "fugitive" }, -- 扩展集成
			})
		end,
	},

	-- 主题插件
	"folke/tokyonight.nvim", -- Tokyo Night 主题
	"Mofiqul/dracula.nvim", -- Dracula 主题
	"rakr/vim-one", -- atom one light主题

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

	-- 文件快速跳转 (vim-easymotion)
	{
		"easymotion/vim-easymotion",
		lazy = true,
		event = "BufRead", -- 读取缓冲区时加载
	},

	-- 文件模糊查找
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			-- 快捷键设置
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		end,
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

	-- 文件树插件配置

	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			-- 配色适配你的 one 主题
			vim.cmd([[
            highlight NvimTreeFolderIcon guifg=#268bd2
            highlight NvimTreeIndentMarker guifg=#586e75
            highlight NvimTreeGitDirty guifg=#d33682
        ]])

			require("nvim-tree").setup({
				renderer = {
					icons = {
						webdev_colors = true, -- 启用文件类型颜色（替代旧版 web_devicons.color）
						show = {
							file = true,
							folder = true,
							folder_arrow = false,
							git = true,
						},
						glyphs = {
							default = "",
							symlink = "",
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌",
							},
							folder = {
								default = "",
								open = "",
								empty = "",
								empty_open = "",
								symlink = "",
							},
						},
					},
					indent_markers = {
						enable = true, -- 缩进线
						icons = {
							corner = "└ ",
							edge = "│ ",
							item = "│ ",
							none = "  ",
						},
					},
					highlight_git = true, -- Git 状态高亮
					add_trailing = true, -- 文件夹尾部斜杠
					group_empty = true, -- 合并空文件夹
				},
				view = {
					width = 35,
					side = "left",
					adaptive_size = true,
				},
				git = {
					enable = true,
					ignore = false,
					timeout = 400,
				},
				vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", {
					noremap = true,
					silent = true,
					desc = "Toggle File Tree",
				}),
			})
		end,
	},

	-- 自动格式化插件配置
	{
		"jose-elias-alvarez/null-ls.nvim",
		lazy = false,
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- 添加不同语言的格式化工具
					null_ls.builtins.formatting.clang_format.with({ -- C/C++
						extra_args = { "--style=file" },
					}),
					null_ls.builtins.formatting.prettier.with({ -- JavaScript/TypeScript/HTML/CSS
						filetypes = {
							"javascript",
							"typescript",
							"html",
							"css",
							"json",
							"yaml",
							"markdown",
						},
					}),
					null_ls.builtins.formatting.stylua, -- Lua
					null_ls.builtins.formatting.black.with({ -- Python
						extra_args = { "--fast" },
					}),
					null_ls.builtins.formatting.shfmt, -- Shell
					null_ls.builtins.formatting.rustfmt, -- Rust
					null_ls.builtins.formatting.gofmt, -- Go
					null_ls.builtins.formatting.terraform_fmt, -- Terraform
					null_ls.builtins.formatting.sqlfmt, -- SQL
					null_ls.builtins.formatting.dart_format, -- Dart
				},
				on_attach = function(client, bufnr)
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},

	-- 语法高亮增强
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "c", "cpp", "lua", "python", "javascript" }, -- 按需添加语言
				highlight = { enable = true }, -- 启用语法高亮
				indent = { enable = true }, -- 智能缩进
			})
		end,
	},

	-- 集成终端
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- ▼▼▼ 新增/修改配置 ▼▼▼
				size = function(term)
					if term.direction == "horizontal" then
						return 20 -- 高度
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4 -- 宽度 40%
					end
				end,

				-- ▼▼▼ 核心配置 ▼▼▼
				shell = "pwsh.exe -nologo", -- Windows

				-- shell = "pwsh -nologo",   -- macOS/Linux
				direction = "horizontal", -- 终端窗口类型: float | horizontal | vertical
				float_opts = {
					border = "curved", -- 窗口边框样式: single | double | shadow | curved
					width = 100, -- 浮动终端宽度百分比
					height = 45, -- 浮动终端高度百分比
				},

				-- ▲▲▲ 操作设置▲▲▲
				open_mapping = [[<C-\>]], -- 开关终端的快捷键（Ctrl+\）
				persist_size = true, -- 记住终端窗口大小
				auto_scroll = true, -- 自动滚动到底部
			})
		end,
	},

	-- Alpha 启动页配置
	{
		"goolord/alpha-nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim", -- 新增必要依赖
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			local path = require("plenary.path") -- 引入路径处理库

			-- 自定义 ASCII 艺术字
			dashboard.section.header.val = {
				[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
				[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
				[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
				[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
				[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
				[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
				[[                                                  ]],
				[[                 ██████╗ ███████╗                 ]],
				[[                ██╔═══██╗██╔════╝                 ]],
				[[                ██║   ██║█████╗                   ]],
				[[                ██║   ██║██╔══╝                   ]],
				[[                ╚██████╔╝██║                      ]],
				[[                 ╚═════╝ ╚═╝                      ]],
				[[                                                  ]],
				[[███████╗██╗   ██╗███████╗███████╗██████╗ ██╗   ██╗]],
				[[╚══███╔╝██║   ██║██╔════╝╚══███╔╝██╔══██╗╚██╗ ██╔╝]],
				[[  ███╔╝ ██║   ██║█████╗    ███╔╝ ██║  ██║ ╚████╔╝ ]],
				[[ ███╔╝  ╚██╗ ██╔╝██╔══╝   ███╔╝  ██║  ██║  ╚██╔╝  ]],
				[[███████╗ ╚████╔╝ ███████╗███████╗██████╔╝   ██║   ]],
				[[╚══════╝  ╚═══╝  ╚══════╝╚══════╝╚═════╝    ╚═╝   ]],
			}

			-- 获取最近项目列表 (修复版本)
			local function get_recent_projects()
				local projects = {}
				local seen = {}

				for _, file in ipairs(vim.v.oldfiles) do
					-- 过滤无效路径
					if vim.fn.filereadable(file) == 1 then
						local project_path = path:new(file):parent().filename
						-- 排除临时文件和非项目路径
						if not project_path:match("tmp") and not seen[project_path] then
							table.insert(projects, {
								display = " " .. path:new(project_path):make_relative(vim.loop.cwd()),
								path = project_path,
							})
							seen[project_path] = true
							if #projects >= 5 then
								break
							end
						end
					end
				end
				return projects
			end

			-- 最近项目展示模块
			local recent_projects = {
				type = "group",
				val = {
					-- { type = "text", val = "Recent Projects", opts = { hl = "AlphaSectionTitle" } },
					{ type = "padding", val = 1 },
					{
						type = "group",
						val = function()
							local buttons = {}
							for _, proj in ipairs(get_recent_projects()) do
								table.insert(
									buttons,
									dashboard.button(
										"p" .. _,
										proj.display,
										"<CMD>cd " .. proj.path .. " | NvimTreeFindFile<CR>"
									)
								)
							end
							return buttons
						end,
					},
				},
			}

			-- 布局配置 (添加项目列表模块)
			dashboard.config.layout = {
				{ -- Header
					type = "group",
					val = {
						{
							type = "padding",
							val = function()
								return math.floor(vim.o.lines * 0.15)
							end,
						},
						dashboard.section.header,
						{ type = "padding", val = 2 },
					},
				},
				recent_projects, -- 插入项目列表
				{ type = "padding", val = 2 },
				{ -- Main Buttons
					type = "group",
					val = {
						dashboard.section.buttons,
						{ type = "padding", val = 1 },
					},
				},
				{ -- Footer
					type = "group",
					val = {
						{
							type = "padding",
							val = function()
								return math.floor(vim.o.lines * 0.1)
							end,
						},
						dashboard.section.footer,
					},
				},
			}

			-- 按钮配置
			dashboard.section.buttons.val = {
				dashboard.button("t", "🌳 File Explorer", "<CMD>NvimTreeToggle<CR>"),
				dashboard.button("f", "🔍 Find Files", "<CMD>Telescope find_files<CR>"),
				dashboard.button("g", "📄 Plugin Manager", "<CMD>Lazy<CR>"),
				dashboard.button("c", "⚙️  Edit Config", "<CMD>edit $MYVIMRC<CR>"),
			}

			-- 动态底部信息
			dashboard.section.footer.val = function()
				local stats = require("lazy").stats()
				local mem_usage = math.floor(collectgarbage("count") / 1024)
				return {
					" ",
					"🚀 Neovim v" .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
					"📦 Plugins: " .. stats.loaded .. "/" .. stats.count,
					"💾 Memory: " .. mem_usage .. "MB",
					"🕒 " .. os.date("%Y-%m-%d %H:%M:%S"),
				}
			end

			alpha.setup(dashboard.config)
		end,
	},
})

-- 自动打开文件树（当以目录方式启动 Neovim 时）
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		-- 仅当打开的是目录时自动启动文件树
		if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
			require("nvim-tree.api").tree.open()
		end
	end,
})

--vim.cmd([[set background=light]]) --设置为浅色背景

-- vim.cmd[[colorscheme tokyonight]] -- Tokyo Night 主题
vim.cmd([[colorscheme dracula]]) -- Dracula 主题
--vim.cmd([[colorscheme one]]) -- 启用 One Light 主题
-- vim.cmd("highlight Normal guibg=NONE")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi NonText guibg=NONE ctermbg=NONE")
vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
