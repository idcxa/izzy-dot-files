let mapleader =","
set clipboard+=unnamedplus

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

""==================================================================""
" Plugins
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
if has('python3')
endif

if !exists('g:vscode')
	call plug#begin('~/.config/nvim/plugged')
	"Plug 'tpope/vim-surround'
	Plug 'scrooloose/nerdtree'
	"Plug 'junegunn/goyo.vim'
	"Plug 'PotatoesMaster/i3-vim-syntax'
	"Plug 'leafo/moonscript-vim'
	"Plug 'jreybert/vimagit'
	"Plug 'vimwiki/vimwiki'
	"Plug 'tpope/vim-commentary'
	"Plug 'vifm/vifm.vim'
	"Plug 'kovetskiy/sxhkd-vim'
	Plug 'flazz/vim-colorschemes'
	Plug 'xolox/vim-colorscheme-switcher'
	Plug 'xolox/vim-misc'
	"Plug 'LaTeX-Box-Team/LaTeX-Box'
	Plug 'itchyny/lightline.vim'
	Plug 'leafo/moonscript-vim'
	"Plug 'FredKSchott/CoVim'
	Plug 'elixir-editors/vim-elixir'
	Plug 'slashmili/alchemist.vim'
	"Plug 'vim-syntastic/syntastic'
	"Plug '907th/vim-auto-save'
	"Plug 'digitaltoad/vim-pug'
	"Plug 'ycm-core/YouCompleteMe'
	Plug 'arrufat/vala.vim'
	Plug 'mbbill/undotree'
	"Plug 'kassio/neoterm'
	Plug 'JuliaEditorSupport/julia-vim'
	Plug 'LnL7/vim-nix'
	Plug 'rust-lang/rust.vim'
	"Plug 'dense-analysis/ale'
	Plug 'itchyny/vim-gitbranch'
	"Plug 'airblade/vim-rooter'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'editorconfig/editorconfig-vim'

	Plug 'roxma/nvim-yarp'
	"Plug 'bling/vim-bufferline'
	"Plug 'bagrat/vim-buffet'
	"Plug 'ryanoasis/vim-devicons'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'romgrk/barbar.nvim'


endif
call plug#end()
set updatetime=300

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" vim rooter
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']

" neoterm
set nocompatible
let &runtimepath.=',~/.vim/bundle/neoterm'

"" nerdtree
" set nerdtree to open with leader v
map <C-n> :NERDTreeToggle <CR>

" make it always open on the right
let g:NERDTreeWinPos = "right"

" change default arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" open nerdtree automatically if vim is started with no args
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree |  endif

" open the same nerdtree on every tab
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" make vim close completely when nerdtree is the last pane open
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" stop other files voring nerdtree
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" bookmark stuffz
let NERDTreeShowBookmarks=1

" barbar
let bufferline = get(g:, 'bufferline', {})
let bufferline.auto_hide = v:true

" Configure icons on the bufferline.
let bufferline.icon_separator_active = '▎'
let bufferline.icon_separator_inactive = '▎'
let bufferline.icon_close_tab = ''
let bufferline.icon_close_tab_modified = '+'
let bufferline.icon_pinned = '車'

""==================================================================""
" Filetypes
if has("autocmd")
	augroup templates
		autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/skeleton.cpp
		autocmd BufNewFile *.c 0r ~/.config/nvim/templates/skeleton.c
		autocmd BufNewFile *.ex 0r ~/.config/nvim/templates/skeleton.ex
		autocmd BufNewFile *.rs 0r ~/.config/nvim/templates/skeleton.rs
	augroup END
endif

au BufNewFile,BufRead *.ex,*.exs
			\ set syntax=elixir |
			\ colorscheme tender

au BufNewFile *.tex
			\ 0r ~/.config/nvim/templates/skeleton.tex |
			\ !cp ~/.config/nvim/templates/structure.tex ./ && mkdir Figures

au BufRead *.tex
			\ set shiftwidth=2 |
			\ set tabstop=2 |
			\ colorscheme tir_black

""==================================================================""
" Colorschemes
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
colorscheme kolor
map <F7> :PrevColorScheme<CR>
map <F8> :NextColorScheme<CR>
map <F9> :RandomColorScheme<CR>

highlight MatchParen cterm=bold ctermfg=208 ctermbg=233 gui=italic guifg=#121212 guibg=#ff8700

" lightline
set noshowmode
" Lightline
let g:lightline = {
			\ 'colorscheme': 'jellybeans',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'filename', 'gitbranch', 'readonly', 'cocstatus', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'gitbranch#name',
			\   'filename': 'LightlineFilename',
			\   'cocstatus': 'coc#status'
			\ },
			\ }
function! LightlineFilename()
	return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" neovide
let g:neovide_cursor_vfx_mode = "wireframe"

""==================================================================""
" basics
set mouse=a
set shiftwidth=4
set tabstop=4
set softtabstop=4
command! Reload :so $MYVIMRC
cnoreabbrev rld Reload
command! Vimrc :vs $MYVIMRC
cnoreabbrev nv Vimrc
set is
set nohls
set inccommand=nosplit
let g:incsearch#auto_nohlsearch = 1
cnoremap kj <c-c>
cnoremap jk <C-C>
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number " relativenumber
set undodir=~/.vimdid
set undofile
set lazyredraw
autocmd StdinReadPre * let s:std_in=1
set splitright
set autoread

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

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


" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
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

" Goyo plugin makes text more readable when writing prose:
map <leader>f :Goyo \| set bg=light \| set linebreak \| colorscheme 1989<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_gb<CR>

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
" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %

"autocmd VimLeave !touch fuck %

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

""==================================================================""
" Shortcuts
function Git(message)
	!git add .
	!git commit -m a:message
endfunction

" elixir
""""""""""""""""""""""""""""""""
autocmd FileType elixir map <F4> :w <bar> !mix escript.build<CR>
autocmd FileType elixir map <F5> :w <bar> !elixir %:t<CR>

"lua
""""""""""""""""""""""""""""""""
autocmd FileType lua map <F3> :wa <bar> !love .<CR>

" ruby
autocmd FileType ruby map <F5> :wa <bar> !./%:t<CR>

" moonscript
""""""""""""""""""""""""""""""""
autocmd FileType moon map <leader>b :w <bar> !moon %:t<CR>
autocmd FileType moon map <leader>n :w <bar> !moonc %:t<CR>

" python
""""""""""""""""""""""""""""""""
autocmd FileType python map <leader>b :w <bar> !python3 %:t<CR>

" rust
""""""""""""""""""""""""""""""""
" cargo
autocmd FileType rust map <leader>c :w <bar> !cargo check<CR>
autocmd FileType rust map <leader>v :w <bar> !cargo test<CR>
autocmd FileType rust map <leader>b :w <bar> !cargo build<CR>
autocmd FileType rust map <leader>n :w <bar> !cargo run<CR>
" rustc
autocmd FileType rust map <F4> :w <bar> !rustc %:t<CR>
autocmd FileType rust map <F5> :w <bar> !./%:r<CR>
" fmt
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" c++
""""""""""""""""""""""""""""""""
" compiling
autocmd FileType cpp map <F3> :w <bar> !make; make clean<CR>
autocmd FileType cpp map <F4> :w <bar> !g++ %:t -std=c++2a -Wall -o %:r<CR>
autocmd FileType cpp map <F5> :w <bar> !./%:r <CR>
" macros
autocmd FileType cpp inoremap ,for for (int abc = <++>; abc <= <++>; abc++) {<Enter><++><Enter>}<Esc>2k :smagic/abc//g<Left><Left>
autocmd FileType cpp inoremap ,it for (std::vector<<++>>::iterator it = abc.begin(); it != abc.end(); it++) {<Enter><++><Enter>}<Esc>2k :s/abc//g<Left><Left>

" LaTeX
""""""""""""""""""""""""""""""""
" Compiling
autocmd FileType tex map <F3> <Esc> :w <bar> !biber %:r<CR>
autocmd FileType tex map <F4> <Esc> :w <bar> !pdflatex %:t<CR>
autocmd FileType tex map <F5> <Esc> :!mupdf %:r.pdf<CR>
" Word count:
autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
" Spellchecker
autocmd FileType tex set spelllang=en_gb spell
" Code snippets
autocmd FileType tex inoremap ,eq \begin{equation*}<Enter><Enter>\end{equation*}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ,al \begin{align}<Enter>\begin{split}<Enter><Enter>\end{split}<Enter>\end{align}<Esc>2kA<Tab><Tab><Tab><Tab>
autocmd FileType tex inoremap ,sp \begin{split}<Enter><Enter>\end{split}<Esc>1kA<Tab>
autocmd FileType tex inoremap ,fr \frac{}{<++>}<++><Esc>10hi
autocmd FileType tex inoremap ,tb \begin{center}<Enter>\begin{tabular}{}<Enter><++><Enter><Esc>i<Tab>\end{tabular}<Enter>\end{center}<Esc>3k13li
autocmd FileType tex inoremap ,hs \hspace{1cm}\\<Enter>
autocmd FileType tex inoremap ,ma $$<++><Esc>4hi

autocmd FileType tex inoremap ,_ _{}<++><Esc>4hi

"autocmd FileType tex inoremap ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
autocmd FileType tex inoremap ,im \begin{figure}[h]<Enter>\centering<Enter>\includegraphics[width=0.6\columnwidth]{}<Enter>\caption{<++>}<Enter>\end{figure}<Enter><Esc>3kA<Esc>i
autocmd FileType tex inoremap ,fi \vspace{0.5cm}<Enter>\begin{Figure}<Enter>\centering<Enter>\includegraphics[width=\columnwidth]{<++>}<Enter>\captionof{figure}{<++>}<Enter>\end{Figure}<Enter>\vspace{0.5cm}<Enter><Enter><Esc>8kA
autocmd FileType tex inoremap ,exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ,em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap ,bf \textbf{}<++><Esc>T{i
autocmd FileType tex vnoremap , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
autocmd FileType tex inoremap ,it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap ,ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap ,cp \parencite{}<++><Esc>T{i
autocmd FileType tex inoremap ,glos {\gll<Space><++><Space>\\<Enter><++><Space>\\<Enter>\trans{``<++>''}}<Esc>2k2bcw
autocmd FileType tex inoremap ,x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
autocmd FileType tex inoremap ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA<Space>
autocmd FileType tex inoremap ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA<Space>
autocmd FileType tex inoremap ,li <Enter>\item<Space>
autocmd FileType tex inoremap ,ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ,ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
autocmd FileType tex inoremap ,can \cand{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ,con \const{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ,v \vio{}<Tab><++><Esc>T{i
autocmd FileType tex inoremap ,a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap ,sc \textsc{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ,st <Esc>F{i*<Esc>f}i
autocmd FileType tex inoremap ,beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
autocmd FileType tex inoremap ,up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex nnoremap ,up /usepackage<Enter>o\usepackage{}<Esc>i
autocmd FileType tex inoremap ,tt \texttt{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ,bt {\blindtext}
autocmd FileType tex inoremap ,nu $\varnothing$
autocmd FileType tex inoremap ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
autocmd FileType tex inoremap ,rn (\ref{})<++><Esc>F}i

""".bib
autocmd FileType bib inoremap ,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
autocmd FileType bib inoremap ,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
autocmd FileType bib inoremap ,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i


