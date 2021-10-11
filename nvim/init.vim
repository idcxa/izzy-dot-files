""" izzy vim izzy vim !!
""==================================================================""

" Absolute Essentials
""==================================================================""
let mapleader =","
let maplocalleader=","
set clipboard+=unnamedplus

source ~/.config/nvim/filetypes.vim
source ~/.config/nvim/plugins.lua
source ~/.config/nvim/nvimtree.vim
autocmd BufWritePost plugins.lua source <afile> | PackerCompile
""==================================================================""

" Plugins
""==================================================================""
" dashboard-nvim
let g:dashboard_custom_header = [
\ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
\ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
\ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
\ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
\ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
\ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
\]

" Default value is clap
let g:dashboard_default_executive ='telescope'

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>

" nerdtree
"================"
"map <C-n> :NERDTreeToggle <CR>
"
"" make it always open on the right
"let g:NERDTreeWinPos = "right"
"
"" change default arrows
"let g:NERDTreeDirArrowExpandable = '▸'
"let g:NERDTreeDirArrowCollapsible = '▾'
"
"" open nerdtree automatically if vim is started with no args
""autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
""autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree |  endif
"
"" open the same nerdtree on every tab
"autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
"
"" make vim close completely when nerdtree is the last pane open
"autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"
"" stop other files voring nerdtree
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
"
"" bookmark stuffz
"let NERDTreeShowBookmarks=1

" barbar
"================"
"let bufferline = get(g:, 'bufferline', {})
"let bufferline.animation = v:true
"let bufferline.auto_hide = v:true
"let bufferline.tabpages = v:false
"let bufferline.closable = v:true
"
"let bufferline.clickable = v:true
"let bufferline.icon_custom_colors = v:false
"let bufferline.insert_at_end = v:true
"let bufferline.icon_separator_active = '▎'
"let bufferline.icon_separator_inactive = '▎'
"let bufferline.icon_close_tab = ''
"let bufferline.icon_close_tab_modified = '+'
"let bufferline.icon_pinned = '車'
"
"" keybinds
"nnoremap <silent>    <C-p>		:BufferPin<CR>
"nnoremap <silent>    <C-w>		:BufferClose<CR>
"nnoremap <silent>    <C-t>		:tabnew <Bar> :NERDTreeFocus<CR> <C-w>h
"
"nnoremap <silent>    <A-1>		:BufferGoto 1<CR>
"nnoremap <silent>    <A-2> 		:BufferGoto 2<CR>
"nnoremap <silent>    <A-3> 		:BufferGoto 3<CR>
"nnoremap <silent>    <A-4> 		:BufferGoto 4<CR>
"nnoremap <silent>    <A-5> 		:BufferGoto 5<CR>
"nnoremap <silent>    <A-6> 		:BufferGoto 6<CR>
"nnoremap <silent>    <A-7> 		:BufferGoto 7<CR>
"nnoremap <silent>    <A-8> 		:BufferGoto 8<CR>
"nnoremap <silent>    <A-9> 		:BufferLast<CR>

nnoremap <silent> <A-left>	:BufferlineMovePrevious<CR>
nnoremap <silent> <A-right>	:BufferlineMoveNext<CR>

nnoremap <silent><A-1> <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><A-2> <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><A-3> <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><A-4> <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><A-5> <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><A-6> <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><A-7> <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><A-8> <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><A-9> <Cmd>BufferLineGoToBuffer 9<CR>

" coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"" vim rooter
"let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']
""==================================================================""

" Aesthetics
""==================================================================""
"colorscheme
set termguicolors "set nice colours
"colorscheme maui
"colorscheme minimalist
"colorscheme seoul256
"colorscheme zellner
"colorscheme adventurous
"colorscheme asmdev
"colorscheme delphi
"colorscheme buttercream
"colorscheme kolor
"colorscheme seattle
"colorscheme izzy
colorscheme palenight
map <F7> :PrevColorScheme<CR>
map <F8> :NextColorScheme<CR>
map <F9> :RandomColorScheme<CR>

" lightline
"================"
let g:lightline = {
			\ 'colorscheme': 'palenight',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'filename', 'gitbranch', 'readonly', 'cocstatus' ] ]
			\ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2v%<',
      \ },
			\ 'component_function': {
			\   'gitbranch': 'LightlineGitStatus',
			\   'filename': 'LightlineFilename',
			\   'cocstatus': 'LightlineCocStatus'
			\ },
			\ }

lua << EOF
	function _G.gitstatus()
		status = vim.api.nvim_exec("echo get(g:, 'coc_git_status', '')", true)
		changes = vim.api.nvim_exec("echo get(b:, 'coc_git_status', '')", true)
		hi = "hi from lua"
		return status:gsub("%*●", ""):gsub("…", "") .. changes:gsub("%  ", " ")
	end
EOF

function! LightlineGitStatus() abort
	let lua = v:lua.gitstatus()
  return lua
endfunction

function! LightlineFilename()
	let filename = expand('%:t') !=# '' ? @% : '[No Name]'
	let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineCocStatus() abort
  let status = coc#status()
  return winwidth(0) > 120 ? status : ''
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! HideAll()
			set noshowmode
			set noruler
			set laststatus=0
			set noshowcmd
endfunction
function! ShowAll()
			set showmode
			set ruler
			set laststatus=2
			set showcmd
endfunction

autocmd FileType dashboard :call HideAll() | autocmd WinLeave <buffer> :call ShowAll()

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=500}
augroup END

" Essentials
""==================================================================""
set mouse=a
set shiftwidth=2
set tabstop=2
set softtabstop=2
command! Reload :so $MYVIMRC
cnoreabbrev rld Reload
command! Vimrc :vs $MYVIMRC
cnoreabbrev nv Vimrc
set is
set nohls
set inccommand=nosplit
let g:incsearch#auto_nohlsearch = 1
nnoremap c "_c
set nocompatible
filetype plugin on
"syntax on " breaks MatchParen highlighting
set encoding=utf-8
set number
set relativenumber
set undodir=~/.vimdid
set undofile
set lazyredraw
autocmd StdinReadPre * let s:std_in=1
set splitright
set autoread
set noshowmode
set foldmethod=syntax
set foldnestmax=1
set indentkeys-=0#
set nosmartindent
set cindent
filetype plugin indent on
set cinkeys-=0#
set indentkeys-=0#
autocmd FileType * set cindent "some file types override it
" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
"
"" Use <TAB> to select the popup menu:
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

set updatetime=300

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" f1 is now esc
noremap <F1> <ESC>
inoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Very magic by default
"nnoremap ? ?\v
"nnoremap / /\v
"cnoremap %s/ %sm/

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Completion
" Better display for messages
set cmdheight=1
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" quit all files
nnoremap <leader>q :qa<CR>

" Set working directory to the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Enable autocompletion:
"set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Jump to start and end of line using the home row keys
map H ^
map L $

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
vnoremap <left> :bp<CR>
vnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

"autocmd BufWritePost *.vim :so $MYVIMRC

" Navigating with guides
inoremap <leader><leader> <Esc>/<Enter>"_c4l
vnoremap <leader><leader> <Esc>/<Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

" Save file as sudo on files that require root permission
"cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
command! -nargs=0 WriteWithSudo execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
cnoreabbrev w! WriteWithSudo

" doesnt work!!!
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)


nnoremap <Space> za
noremap <2-LeftMouse> zo
autocmd BufRead *.vim set foldmethod=manual
autocmd BufWritePost *.vim mkview
autocmd BufRead *.vim loadview

" Functions
""==================================================================""

function! ConditionalPairMap(open, close)
  let line = getline('.')
  let col = col('.')
  if col < col('$') || stridx(line, a:close, col + 1) != -1
    return a:open
  else
    return a:open . a:close . repeat("\<left>", len(a:close))
  endif
endf
"inoremap <expr> ( ConditionalPairMap('(', ')')
"inoremap <expr> { ConditionalPairMap('{', '}')
"inoremap <expr> [ ConditionalPairMap('[', ']')
"inoremap <expr> < ConditionalPairMap('<', '>')

function s:CompleteTags()
  inoremap <buffer> > ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
  inoremap <buffer> ><Leader> >
  inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction
autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()

function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    tabnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction

