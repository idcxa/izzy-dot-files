"au VimEnter * !setxkbmap -option caps:escape
"au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
if has('python3')
endif

" Tab Indents
set shiftwidth=4
"set expandtab

au BufNewFile,BufRead js
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

au BufNewFile,BufRead py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

au BufNewFile,BufRead *.moon
    \ set syntax=moon |
    \ 30vsp %:r.lua | set syntax=lua | e! | 10sp %:r.out | set syntax=moon

au BufNewFile,BufRead *.ex
    \ colorscheme tender

" SKELTON

if has("autocmd")
    augroup templates
        autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/skeleton.cpp
        autocmd BufNewFile *.c 0r ~/.config/nvim/templates/skeleton.c
        autocmd BufNewFile *.ex 0r ~/.config/nvim/templates/skeleton.ex
    augroup END
endif

au BufNewFile *.tex
    \ 0r ~/.config/nvim/templates/skeleton.tex |
    \ !cp ~/.config/nvim/templates/structure.tex ./ && mkdir Figures

au BufRead *.tex
    \ set shiftwidth=2 |
    \ colorscheme tir_black |

" Folding
set foldmethod=indent
set foldlevel=99
if !exists('g:vscode')
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'jreybert/vimagit'
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-commentary'
Plug 'vifm/vifm.vim'
Plug 'kovetskiy/sxhkd-vim'
Plug 'flazz/vim-colorschemes'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'itchyny/lightline.vim'
Plug 'leafo/moonscript-vim'
Plug 'FredKSchott/CoVim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'vim-syntastic/syntastic'
Plug '907th/vim-auto-save'
Plug 'machakann/vim-sandwich'

let g:auto_save = 1  " enable AutoSave on Vim startup

" Syntastic
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        "let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
        let g:syntastic_tex_checkers = ['proselint']
        let g:syntastic_enable_balloons = 1

" Julia
Plug 'JuliaEditorSupport/julia-vim'
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
endif

call plug#end()
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
"colorscheme zellner
"colorscheme adventurous
"colorscheme asmdev
"colorscheme delphi
"colorscheme buttercream
"colorscheme kolor
colorscheme maui
hi MatchParen cterm=bold ctermfg=208 ctermbg=233 gui=italic guifg=#121212 guibg=#ff8700

set noshowmode
let g:lightline = { 'colorscheme': 'jellybeans', }

" Some basics:
        cnoremap kj <c-c>
        cnoremap jk <C-C>
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number " relativenumber
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	map <F7> :PrevColorScheme<CR>
	map <F8> :NextColorScheme<CR>
	map <F9> :RandomColorScheme<CR>
" Enable autocompletion:
	set wildmode=longest,list,full
" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak \| colorscheme maui<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
	map <leader>o :setlocal spell! spelllang=en_gb<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
	set splitbelow splitright


" Nerd tree
	map <C-n> :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Shortcutting split navigation, saving a keypress:
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Check file in shellcheck:
	map <leader>s :!clear && shellcheck %<CR>

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Replace all is aliased to S.
	nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
	"map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
	autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
	autocmd BufRead,BufNewFile *.tex set filetype=tex

" Enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=90
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo \| set bg=light

" Automatically deletes all trailing whitespace on save.
	autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated, renew bash and vifm configs with new material:
	autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
	autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Navigating with guides
	inoremap <leader><leader> <Esc>/<Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map <leader><leader> <Esc>/<++><Enter>"_c4l

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"""CONFIG
""" PARENTHESIS
	vmap <C-9> c(<c-r><c-o>")
	vmap <C-S-[> c{<c-r><c-o>"}
	vmap <C-[> c[<c-r><c-o>"]

	" Compiling
	autocmd FileType h imap <F4> <Esc> :w <bar> !make clean install<CR>
	autocmd FileType h imap <F4> <Esc> :w <bar> !make clean install<CR>

"""ELIXIR
	autocmd FileType elixir map <F5> :w <bar> !elixir %:t<CR>

"""RUST
	autocmd FileType rust map <F4> :w <bar> !rustc %:t<CR>
	autocmd FileType rust map <F5> :w <bar> !./%:r<CR>
"""PYTHON
	autocmd FileType python map <F5> :w <bar> !python3 %:t<CR>
	autocmd FileType python inoremap ,pr print()<Esc>i

"""JAVA PLUGIN
	autocmd FileType java imap <F4> <Esc> :w <bar> !mvn clean install; scp target/*.jar minecraft@192.168.0.14:/opt/minecraft/heaven/plugins/<CR>

"""SCALA
	" Compiling
	autocmd FileType scala map <F4> :w <bar> !scalac %:t<CR>
	autocmd FileType scala map <F5> :w <bar> !scala %:r <CR>

"""JULIA
	" Compiling
	autocmd FileType julia map <F5> :w <bar> !julia %:t<CR>
"""LUA
	" Compiling
	autocmd FileType lua map <F5> :w <bar> !lua %:t <CR>
	autocmd FileType lua map <F4> :w <bar> !luajit %:t <CR>
	autocmd FileType lua map <F3> :w <bar> !love . <CR>

""" MOONSCRIPT
        " Compiling
        autocmd FileType moon map <F5> :w <bar> !moon %:t &> %:r.out && cat %:r.out<CR>
        " Linting
        autocmd FileType moon map <F6> :w <bar> !moonc -l %:t &> %:r.out <CR>
        autocmd FileType moon map <F4> :w <bar> !moonc %:t <CR>

""" HASKELL
        autocmd FileType haskell map <F4> :w <bar> !ghc -dynamic %:t <CR>
        autocmd FileType haskell map <F5> :w <bar> !./%:r <CR>

""" C
	" Comments
	autocmd FileType c vmap <C-c> c/* <c-r><c-o>" */<Esc>
	autocmd FileType c nmap <C-c> ^<s-c>/* <c-r>" */<Esc>
	autocmd FileType c imap <C-c> <Esc>^<s-c>/* <c-r>" */<Esc>
	"autocmd FileType C vmap <C-c> :w <CR>
        " Compiling
        let $ssh_directory = "jc02003@access.eps.surrey.ac.uk"
        function! RemoteCCompiling()
            w
            echo "Copying files to remote machine"
            !scp -q %:t $ssh_directory:~/compiling/
            echo "Compiling"
            !ssh -q $ssh_directory "cd ~/compiling && gcc -ansi -Wall %:t -o %:r &> %:r.out && rm -f %:t"
            echo "Copying files to host machine"
            !rm -f %:r.out && scp -q $ssh_directory:~/compiling/%:r* ./
            !cat %:r.out
        endfunction

	autocmd FileType c map <F4> :call RemoteCCompiling()<CR>
	autocmd FileType c map <F5> :w <bar> !rm -f %:r.out && ./%:r &> %:r.out<CR>
        " remote compiling on jc02003@access.eps.surrey.ac.uk
	autocmd FileType c map <F6> :10sp %:r.out <bar> e! <bar> set syntax=c<CR>

"""CPP
	" Compiling
	autocmd FileType cpp map <F3> :w <bar> !g++ %:t -o %:r -Wall -g -std=c++2a<CR>
	autocmd FileType cpp map <F4> :wa <bar> !make; make clean<CR>
	autocmd FileType cpp map <F5> :w <bar> !./%:r<CR>
        " Julia in C
	" autocmd FileType cpp map <F4> :w <bar> !g++ %:t -o %:r -std=c++2a -fPIC -I$JULIA_DIR/include/julia -L$JULIA_DIR/lib -Wl,-rpath,$JULIA_DIR/lib -ljulia -llua -ldl<CR>
	autocmd FileType cpp map <F6> :10sp %:r.out <bar> e! <bar> set syntax=cpp<CR>
	" autocmd FileType cpp map <F5> :w <bar> !./%:r <CR>
	" Allegro
	" autocmd FileType cpp map <F4> :w <bar> !g++ %:t -o %:r -pipe -std=c++17 `pkg-config --libs allegro-5 allegro_font-5 allegro_ttf-5 allegro_main-5 allegro_primitives-5 allegro_color-5 allegro_image-5 allegro_dialog-5` -llua -ldl<CR>
	" SFML
	"autocmd FileType cpp map <F4> :w <bar> !g++ -std=c++17 %:t -o %:r<CR>
	" autocmd FileType cpp map <F5> :!g++ %:r.o -o %:r -lsfml-graphics -lsfml-window -lsfml-system <CR> :w <bar> !./%:r <CR>

	" Shortcuts
	autocmd FileType cpp inoremap ,for for (int <++> = <++>; <++> <= <++>; <++>++) {<Enter><++><Enter>}<Esc>2k25
	autocmd FileType cpp inoremap ,it for (std::vector<<++>>::iterator it = <++>.begin(); it != <++>.end(); it++) {<Enter><++><Enter>}<Esc>2k25
	autocmd FileType cpp inoremap ,if if (<++>) {<Enter><++><Enter>} <++><Esc>2k25

"""LATEX
	" Compiling
	autocmd FileType tex imap <F4> <Esc> :w <bar> !pdflatex %:t<CR>
	autocmd FileType tex map <F4> <Esc> :w <bar> !pdflatex %:t<CR>
	autocmd FileType tex map <F5> <Esc> :!mupdf %:r.pdf<CR>
	" Word count:
	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>
	" Spellchecker
	"autocmd FileType tex set spelllang=en_gb spell
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






"""HTML
	autocmd FileType html,javascript,typescript inoremap ,b <b></b><Space><++><Esc>FbT>i
	autocmd FileType html,javascript,typescript inoremap ,it <em></em><Space><++><Esc>FeT>i
	autocmd FileType html,javascript,typescript inoremap ,1 <h1></h1><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html,javascript,typescript inoremap ,2 <h2></h2><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html,javascript,typescript inoremap ,3 <h3></h3><Enter><Enter><++><Esc>2kf<i
	autocmd FileType html,javascript,typescript inoremap ,p <p></p><Enter><Enter><++><Esc>02kf>a
	autocmd FileType html,javascript,typescript inoremap ,a <a<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html,javascript,typescript inoremap ,e <a<Space>target="_blank"<Space>href=""><++></a><Space><++><Esc>14hi
	autocmd FileType html,javascript,typescript inoremap ,ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html,javascript,typescript inoremap ,li <Esc>o<li></li><Esc>F>a
	autocmd FileType html,javascript,typescript inoremap ,ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf<i
	autocmd FileType html,javascript,typescript inoremap ,im <img src="" alt="<++>"><++><esc>Fcf"a
	autocmd FileType html,javascript,typescript inoremap ,td <td></td><++><Esc>Fdcit
	autocmd FileType html,javascript,typescript inoremap ,tr <tr></tr><Enter><++><Esc>kf<i
	autocmd FileType html,javascript,typescript inoremap ,th <th></th><++><Esc>Fhcit
	autocmd FileType html,javascript,typescript inoremap ,tab <table><Enter></table><Esc>O
	autocmd FileType html,javascript,typescript inoremap ,gr <font color="green"></font><Esc>F>a
	autocmd FileType html,javascript,typescript inoremap ,rd <font color="red"></font><Esc>F>a
	autocmd FileType html,javascript,typescript inoremap ,yl <font color="yellow"></font><Esc>F>a
	autocmd FileType html,javascript,typescript inoremap ,dt <dt></dt><Enter><dd><++></dd><Enter><++><esc>2kcit
	autocmd FileType html,javascript,typescript inoremap ,dl <dl><Enter><Enter></dl><enter><enter><++><esc>3kcc
	autocmd FileType html inoremap &<space> &amp;<space>
	autocmd FileType html inoremap á &aacute;
	autocmd FileType html inoremap é &eacute;
	autocmd FileType html inoremap í &iacute;
	autocmd FileType html inoremap ó &oacute;
	autocmd FileType html inoremap ú &uacute;
	autocmd FileType html inoremap ä &auml;
	autocmd FileType html inoremap ë &euml;
	autocmd FileType html inoremap ï &iuml;
	autocmd FileType html inoremap ö &ouml;
	autocmd FileType html inoremap ü &uuml;
	autocmd FileType html inoremap ã &atilde;
	autocmd FileType html inoremap ẽ &etilde;
	autocmd FileType html inoremap ĩ &itilde;
	autocmd FileType html inoremap õ &otilde;
	autocmd FileType html inoremap ũ &utilde;
	autocmd FileType html inoremap ñ &ntilde;
	autocmd FileType html inoremap à &agrave;
	autocmd FileType html inoremap è &egrave;
	autocmd FileType html inoremap ì &igrave;
	autocmd FileType html inoremap ò &ograve;
	autocmd FileType html inoremap ù &ugrave;


""".bib
	autocmd FileType bib inoremap ,a @article{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>journal<Space>=<Space>{<++>},<Enter>volume<Space>=<Space>{<++>},<Enter>pages<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i
	autocmd FileType bib inoremap ,b @book{<Enter>author<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>6kA,<Esc>i
	autocmd FileType bib inoremap ,c @incollection{<Enter>author<Space>=<Space>{<++>},<Enter>title<Space>=<Space>{<++>},<Enter>booktitle<Space>=<Space>{<++>},<Enter>editor<Space>=<Space>{<++>},<Enter>year<Space>=<Space>{<++>},<Enter>publisher<Space>=<Space>{<++>},<Enter>}<Enter><++><Esc>8kA,<Esc>i

"MARKDOWN
	autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
	autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
	autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
	autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
	autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
	autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
	autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
	autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
	autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
	autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
	autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

""".xml
	autocmd FileType xml inoremap ,e <item><Enter><title><++></title><Enter><guid<space>isPermaLink="false"><++></guid><Enter><pubDate><Esc>:put<Space>=strftime('%a, %d %b %Y %H:%M:%S %z')<Enter>kJA</pubDate><Enter><link><++></link><Enter><description><![CDATA[<++>]]></description><Enter></item><Esc>?<title><enter>cit
	autocmd FileType xml inoremap ,a <a href="<++>"><++></a><++><Esc>F"ci"

