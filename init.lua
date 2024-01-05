-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
-- vim.g.shellcmdflag= '-c'

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '|' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp',
          require('gitsigns').prev_hunk, { buffer = bufnr,
            desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'onedark'
-- Lua
  require('onedark').setup {
      style = 'darker'
  }
  require('onedark').load()
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help indent_blankline.txt`
  --   opts = {
  --     char = '┊',
  --     show_trailing_blankline_indent = false,
  --   },
  -- },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

 {
  "AckslD/nvim-neoclip.lua",
  requires = {
    -- you'll need at least one of these
    -- {'nvim-telescope/telescope.nvim'},
    -- {'ibhagwan/fzf-lua'},
  },
  config = function()
    require('neoclip').setup()
  end,
},

 {
	'LukasPietzschmann/telescope-tabs',
	requires = { 'nvim-telescope/telescope.nvim' },
	config = function()
		require'telescope-tabs'.setup{
		}
	end
 },

 {'jpalardy/vim-slime',
 config = function()
 -- vim.g.slime_target='tmux'
 -- vim.g.slime_paste_file='C:/Users/Md.Ali/.slime_paste'
 end},

{
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
},

{   'HiPhish/nvim-ts-rainbow2'},

{
	"nikvdp/neomux"

},

  {'dstein64/vim-startuptime'},
  {'nvim-tree/nvim-web-devicons'},
  {'nvim-tree/nvim-tree.lua', config = function()
      require('nvim-tree').setup{}
    end},

    -- 'cljoly/telescope-repo.nvim',
    'airblade/vim-rooter',
    -- 'LinArcX/telescope-env.nvim',
--     {'mhinz/vim-startify', config = function()
--   vim.g.startify_lists = {
--     {type = 'dir',       header = {'   Current Directory ' .. vim.fn.getcwd()}},
--     {type = 'files',     header = {'   Files'}},
--     {type = 'sessions',  header = {'   Sessions'}},
--     {type = 'bookmarks', header = {'   Bookmarks'}},
--     {type = 'commands',  header = {'   Commands'}}
-- }
--   end
--   },
-- yet another repl 
  -- { 'milanglacier/yarepl.nvim', config = true },
  -- Lua
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
     sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },

        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
-- {"rktjmp/highlight-current-n.nvim"},
-- {
--   "jackMort/ChatGPT.nvim",
--     event = "VeryLazy",
--     config = function()
--       require("chatgpt").setup({
--
--     api_key_cmd = "gpg --decrypt --passphrase ' ' ~/nvim.gpg > /dev/null",
--
-- popup_layout = {
--       default = "right",
--       -- center = {
--       --   width = "50%",
--       --   height = "50%",
--       -- },
--       right = {
--         width = "30%",
--         width_settings_open = "50%",
--       },
--     },
--   openai_edit_params = {
--       model = "gpt-3.5-turbo",
--       temperature = 0,
--       top_p = 1,
--       n = 1,
--     },
--
--       })
--     end,
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim"
--     }
-- },
  -- {'github/copilot.vim'},
  --   { "zbirenbaum/copilot.lua",
  -- cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  --
  -- },
  {'hrsh7th/cmp-path',
    config=function()

require'cmp'.setup {
  sources = {
    { name = 'path' }
  }}
    end
},

  {'hrsh7th/cmp-buffer',
    config=function()

require'cmp'.setup {
  sources = {
    { name = 'buffer' }
  }}
    end
},
{'kevinhwang91/nvim-hlslens',
  config=function ()
require('hlslens').setup({
calm_down = true,
    nearest_only = true,
    nearest_float_when = 'always'

      })
  end},
  {'danilamihailov/beacon.nvim'},
  {'miversen33/netman.nvim'},
  -- {'nvim-orgmode/orgmode',
  --     ft = {'org'},
  --     config = function()
  --             require('orgmode').setup{}
  --     end
  --     },
-- {"rktjmp/highlight-current-n.nvim",
--  config = function()
-- require("highlight_current_n").setup({
--   highlight_group = "IncSearch" -- highlight group name to use for highlight
-- })
--     end
--
--   },

 --
    -- {'vim-pandoc/vim-pandoc'}
    -- { 'vim-pandoc/vim-pandoc-syntax' },
    -- { 'vim-pandoc/vim-rmarkdown', branch = 'official-filetype' },
    -- { 'quarto-dev/quarto-vim' },
  -- { 'milanglacier/yarepl.nvim', config = true },
  -- 'TC72/telescope-tele-tabby.nvim',
  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})

require'lspconfig'.pyright.setup{}
require'lspconfig'.r_language_server.setup{}

-- load_extension

-- require('telescope').load_extension'repo'
-- require('telescope').extensions.tele_tabby.list()
require('telescope').load_extension'neoclip'
-- require('telescope').load_extension('env')
require('telescope').load_extension('telescope-tabs')
require('telescope').load_extension('projects')
require("telescope").load_extension "file_browser"
-- require'telescope'.extensions.projects.projects{}

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
-- vim.o.hlsearch = false

-- Make line numbers default
-- vim.wo.number = false
-- vim.wo.numberwidth=1

vim.opt.relativenumber = true
-- vim.opt.shell = "C:/msys64/usr/bin/bash.exe"
-- vim.opt.shellcmdflag = '-c'
-- vim.opt.shellslash = 'shellslash'


-- vim.cmd([[ 
-- if $SHELL == "C:/msys64/usr/bin/bash"
--     let &shellcmdflag = '-c'
--     set shellxquote=(
--     set shellslash
-- endif
-- )
--
-- ]])
-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.showtabline=0
-- vim.o.guifont = 'Hack Nerd Font:h12'
-- vim.o.guifont = 'Fira Mono:h12'
vim.o.guifont = 'Fira Code Retina:h12'
-- vim.o.bg = '#18191c'
-- vim.o.bg = 'dark'
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- vim.o.shell = 'C:/"Program Files"/Git/bin/bash.exe'
-- vim.o.shell = 'C:/msys64/usr/bin/bash.exe'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Our example init.lua file

-- Import & assign the map() function from the utils module
local map = require("utils").map

map("n", "<leader>w", "<C-w>")
map("n", "<leader>pp", ":Telescope projects <CR>")
map("n", "<leader><Tab>.", ":Telescope telescope-tabs list_tabs <CR>")
map("n", "<leader>pn", ":tabnew <CR>")
-- map("n", "<leader>st", ":Startify <CR>")
map("t", "<Esc>", "<C-\\><C-n>")
-- map("n", "n", "nzz")
-- map("n", "N", "Nzz")
map("n", "<leader>e", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
map("n", "<leader>tr", ":vert term <CR>")
map("n", "<leader>ji", ":echo &channel <CR>")
map('n', '<Leader>sss', ":s#\\\\#/#g <CR>")
-- map("n", "<leader>rs", ":REPLStart! <CR>")
-- telescope file browser keymap
map("n", "<leader>fb", ":Telescope file_browser <CR>")
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })

vim.keymap.set('n', '<leader>,', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').buffers(require('telescope.themes').get_dropdown {
    previewer = false,
    initial_mode = 'normal',
    prompt_title = 'Buffers',
  })
end, { desc = '[,] Find recently opened buffers' })

-- vim.keymap.set('n', '<leader>,', function()
--   require('telescope.builtin').buffers(require('telescope.themes'), { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>.', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })




-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  -- ensure_installed = { 'c', 'cpp', 'go', 'lua','r', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },
  ensure_installed = { 'lua','r', 'python',  'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = true,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python', 'r'} },
  -- indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
 rainbow = {
    enable = true,
    -- list of languages you want to disable the plugin for
    disable = { 'jsx', 'cpp' },
    -- Which query to use for finding delimiters
    query = 'rainbow-parens',
    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  -- nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

require'nvim-web-devicons'.setup {
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 }}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local function run_cmd_with_count(cmd)
    return function()
        vim.cmd(string.format('%d%s', vim.v.count, cmd))
    end
end

local ft_to_repl = {
    r = 'radian',
    rmd = 'radian',
    quarto = 'radian',
    markdown = 'radian',
    ['markdown.pandoc'] = 'radian',
    python = 'ipython',
    sh = 'bash',
    REPL = '',
}

-- local keymap = vim.api.nvim_set_keymap
-- local bufmap = vim.api.nvim_buf_set_keymap
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd('FileType', {
--     pattern = { 'quarto', 'r', 'markdown', 'markdown.pandoc', 'rmd', 'python', 'sh', 'REPL' },
--     desc = 'set up REPL keymap',
--     callback = function()
--         bufmap(0, 'v', '<C-Enter>', '', {
--             callback = run_cmd_with_count 'REPLSendVisual',
--             desc = 'Send visual region to REPL',
--         })
--         bufmap(0, 'n', '<C-Enter>', '', {
--             callback = run_cmd_with_count 'REPLSendLine',
--             desc = 'Send current line to REPL',
--         })
--
--         bufmap(0, 'i', '<C-Enter>', '', {
--             callback = run_cmd_with_count 'REPLSendLine',
--             desc = 'Send current line to REPL',
--         })
--         bufmap(0, 'n', '<LocalLeader>sm', '', {
--             callback = run_cmd_with_count 'REPLSendMotion',
--             desc = 'Send motion to REPL',
--         })
-- end,
-- })

-- ChatGPT keymap settings 
-- vim.api.nvim_set_keymap("n", "<Leader>cg", ":ChatGPT<CR>", {noremap = true, silent = true})
-- vim.api.nvim_set_keymap("n", "<Leader>cc", ":ChatGPTCompleteCode<CR>", {noremap = true, silent = true})

-- lhslens search highlight
local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)

-- org mode 
-- Load custom treesitter grammar for org filetype
-- require('orgmode').setup_ts_grammar()

-- Treesitter configuration
require('nvim-treesitter.configs').setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop,
  -- highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    -- Required for spellcheck, some LaTex highlights and
    -- code block highlights that do not have ts grammar
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

-- require('orgmode').setup({
--   org_agenda_files = {'~/org'},
--   org_default_notes_file = '~/org/meetings.org',
-- })

-- let &shell = "C:/msys64/usr/bin/bash.exe"
-- ter "'C:/Program Files/Git/bin/bash.exe'"



