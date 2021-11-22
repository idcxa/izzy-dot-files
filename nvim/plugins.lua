local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute 'packadd packer.nvim'
end

return require('packer').startup(function()

	-- let packer manage itself
	use 'wbthomason/packer.nvim'

	-- doesnt work :(
	use {
		'glepnir/dashboard-nvim',
		requires = {
			'liuchengxu/vim-clap'
		}
	}

	use 'tjdevries/train.nvim'
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		}
	}

	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
		}
	}
	use 'christoomey/vim-tmux-navigator'

	use {
    'kyazdani42/nvim-tree.lua',
		commit = "67805502d2a126a4c40466059db8f1770a6625d4",
    requires = 'kyazdani42/nvim-web-devicons'
	}

	use "jbyuki/venn.nvim"
	use 'arecarn/vim-selection'
	use 'arecarn/vim-crunch'

	-- qol
	--use 'scrooloose/nerdtree'
	use 'xolox/vim-misc'
	use 'itchyny/lightline.vim'
	use 'mbbill/undotree'
	--use 'romgrk/barbar.nvim'
	use 'nvim-treesitter/nvim-treesitter'
	use 'romgrk/nvim-treesitter-context'
	use {'akinsho/bufferline.nvim',
		requires = 'kyazdani42/nvim-web-devicons',

	}

	-- coc
	use {'neoclide/coc.nvim', branch = 'release'}

	vim.cmd([[let g:coc_global_extensions = ['coc-tsserver' ]
	]])

	-- aesthetics
	use 'flazz/vim-colorschemes'
	use 'joshdick/onedark.vim'
	use 'sainnhe/sonokai'
	use {'sonph/onehalf', rtp = 'vim/'}
	use 'drewtempelmeyer/palenight.vim'
	use 'xolox/vim-colorscheme-switcher'
	use 'kyazdani42/nvim-web-devicons'

	-- languages
	use 'sheerun/vim-polyglot'
	use 'elixir-editors/vim-elixir'
	use 'slashmili/alchemist.vim'
	use 'JuliaEditorSupport/julia-vim'
	use 'LnL7/vim-nix'
	use 'editorconfig/editorconfig-vim'
	use 'rust-lang/rust.vim'
	--use 'Olical/conjure'

	-- lua, yes it needs its own section
	use 'tjdevries/nlua.nvim'
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/completion-nvim'
	use 'euclidianAce/BetterLua.vim'
	use 'tjdevries/manillua.nvim'

	-- webdev
	use 'digitaltoad/vim-pug'
	use 'pangloss/vim-javascript'
	use 'leafgarland/typescript-vim'
	use 'peitalin/vim-jsx-typescript'
	use 'maxmellon/vim-jsx-pretty'
	use {'styled-components/vim-styled-components', branch = 'main'}
	use 'jparise/vim-graphql'
	use 'JulesWang/css.vim'
	use 'cakebaker/scss-syntax.vim'
	use 'AndrewRadev/tagalong.vim'
	use 'lepture/vim-jinja'

	vim.cmd([[
		autocmd FileType scss set iskeyword+=-
		if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
		  let g:coc_global_extensions += ['coc-prettier']
		endif
		if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
		  let g:coc_global_extensions += ['coc-eslint']
		endif
	]])

	require('bufferline').setup {
  options = {
    numbers = "none" ,
    --- @deprecated, please specify numbers as a function to customize the styling
    --numbers = "lower", -- buffer_id at index 1, ordinal at index 2
    close_command = "bdelete! %d",       -- can be a string or function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string or function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string or function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string or function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '+',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "coc",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return "("..count..")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
        return true
      end
    end,
    offsets = {{filetype = "NvimTree", text = "File Manager", text_align = "center"}},
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { 'or', 'or' }
    separator_style = "thick",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = 'id' or 'extension' or 'relative_directory' or 'directory' or 'tabs' or function(buffer_a, buffer_b)
      -- add custom logic
      return buffer_a.modified > buffer_b.modified
    end
  }
}

end)


