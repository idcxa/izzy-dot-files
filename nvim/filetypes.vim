" templates
""""""""""""""""""""""""""""""""
if has("autocmd")
	augroup templates
		autocmd BufNewFile *.cpp 0r ~/.config/nvim/templates/skeleton.cpp
		autocmd BufNewFile *.c 0r ~/.config/nvim/templates/skeleton.c
		autocmd BufNewFile *.ex 0r ~/.config/nvim/templates/skeleton.ex
		autocmd BufNewFile *.rs 0r ~/.config/nvim/templates/skeleton.rs
	augroup END
endif

"au BufNewFile,BufRead *
		""\ colorscheme palenight
"		\ colorscheme sonokai

" elixir
""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.ex,*.exs
			\ set syntax=elixir |
			\ colorscheme tender

autocmd FileType elixir map <F4> :w <bar> !mix escript.build<CR>
autocmd FileType elixir map <F5> :w <bar> !elixir %:t<CR>

" javascript/react
""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.scss,*.sass,*.jade,*.pug
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			"\ iabbrev </ </<C-X><C-O> |

au BufNewFile,BufRead *.js,*.jsx,*.ts,*.tsx
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			"\ colorscheme onehalfdark

" clojure
""""""""""""""""""""""""""""""""
au BufEnter *.clj,*.cljs
			\ set tabstop=2 |
			\ set shiftwidth=2 |
			"\ colorscheme palenight

"lua
""""""""""""""""""""""""""""""""
autocmd FileType lua map <F3> :wa <bar> !love .<CR>

" ruby
""""""""""""""""""""""""""""""""
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
au BufRead *.tex
			\ set shiftwidth=2 |
			\ set tabstop=2 |
			\ colorscheme tigrana-256-dark
			"\ colorscheme tir_black"

au BufNewFile *.tex
			\ 0r ~/.config/nvim/templates/skeleton.tex |
			\ !cp ~/.config/nvim/templates/structure.tex ./ && mkdir Figures

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !rm -rf *.log *.out *.aux
autocmd BufWritePost *.tex silent !pdflatex %

" Compiling
autocmd FileType tex map <F3> :w <bar> !biber %:r<CR>
autocmd FileType tex map <F4> :w <bar> !pdflatex %:t<CR>
autocmd FileType tex map <F5> :silent !zathura %:r.pdf &<CR>
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

