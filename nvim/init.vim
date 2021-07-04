let mapleader =","

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
	Plug 'junegunn/goyo.vim'
	Plug 'PotatoesMaster/i3-vim-syntax'
	Plug 'leafo/moonscript-vim'
	"Plug 'jreybert/vimagit'
	"Plug 'vimwiki/vimwiki'
	"Plug 'tpope/vim-commentary'
	Plug 'vifm/vifm.vim'
	"Plug 'kovetskiy/sxhkd-vim'
	Plug 'flazz/vim-colorschemes'
	Plug 'xolox/vim-colorscheme-switcher'
	Plug 'xolox/vim-misc'
	"Plug 'LaTeX-Box-Team/LaTeX-Box'
	Plug 'itchyny/lightline.vim'
	"Plug 'leafo/moonscript-vim'
	"Plug 'FredKSchott/CoVim'
	Plug 'elixir-editors/vim-elixir'
	Plug 'slashmili/alchemist.vim'
	"Plug 'vim-syntastic/syntastic'
	"Plug '907th/vim-auto-save'
	Plug 'digitaltoad/vim-pug'
	"Plug 'ycm-core/YouCompleteMe'
	Plug 'arrufat/vala.vim'
	Plug 'mbbill/undotree'
	Plug 'kassio/neoterm'
	Plug 'JuliaEditorSupport/julia-vim'
	Plug 'LnL7/vim-nix'
	Plug 'rust-lang/rust.vim'
	"Plug 'dense-analysis/ale'
	Plug 'itchyny/vim-gitbranch'
	Plug 'airblade/vim-rooter'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'editorconfig/editorconfig-vim'

	Plug 'puremourning/vimspector'
	let g:vimspector_enable_mappings = 'HUMAN'

	Plug 'roxma/nvim-yarp'

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

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"  'on_complete': ['ncm2#on_complete#delay', 180,
"               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
			\ 'name' : 'css',
			\ 'priority': 9,
			\ 'subscope_enable': 1,
			\ 'scope': ['css','scss'],
			\ 'mark': 'css',
			\ 'word_pattern': '[\w\-]+',
			\ 'complete_pattern': ':\s*',
			\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
			\ })

" vim rooter
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']

" ale
"let b:ale_linters = {'rust': ['cargo', 'rls', 'rustc']}
"let g:ale_fixers = {'rust': ['rustfmt', 'remove_trailing_lines', 'trim_whitespace']}
"let g:ale_lint_on_save = 1
"let g:ale_fix_on_save = 1
"let g:rustfmt_autosave = 1
"let g:ale_shell = '/bin/bash'

" neoterm
set nocompatible
let &runtimepath.=',~/.vim/bundle/neoterm'

" nerdtree
map <C-n> :NERDTreeToggle <CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree |  endif
let NERDTreeShowBookmarks=1

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

au BufRead,BufNewFile *.love
			\ set syntax=lua

""==================================================================""
" Colorschemes
colorscheme maui
colorscheme minimalist
"colorscheme zellner
"colorscheme adventurous
"colorscheme asmdev
"colorscheme delphi
"colorscheme buttercream
"colorscheme kolor
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

" coc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 'Smart' nevigation
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
:cd
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Brighter comments
"call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
"call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

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

" moonscript
""""""""""""""""""""""""""""""""
autocmd FileType moon map <leader>b :w <bar> !moon %:t<CR>
autocmd FileType moon map <leader>n :w <bar> !moonc %:t<CR>

" rust
""""""""""""""""""""""""""""""""
" cargo
autocmd FileType rust map <leader>v :w <bar> !cargo check<CR>
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


