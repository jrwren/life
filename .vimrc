" Vim
" An example for a gvimrc file.
" The commands in this are executed when the GUI is started.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"             for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
" Make external commands work through a pipe instead of a pseudo-tty

filetype off "it turns on later
"pathogen https://github.com/tpope/vim-pathogen
call pathogen#infect()
call pathogen#helptags()

"set noguipty
" set the X11 font to use. See 'man xlsfonts' on unix/linux
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
"set guifont=8x13bold
"set guifont=9x15bold
"set guifont=7x14bold
"set guifont=7x13bold
"set guifont=Monaco:h11
"set guifont=Envy\ Code\ R:h14
"set guifont=Lucida\ Console:h12
"set guifont=Inconsolata:h13
"set guifont=monofur:h13
"set guifont=ProggyTiny
"set guifont=DejaVu\ Sans\ Mono
"set guifont=Ubuntu\ Mono:h14
"set guifont=Menlo\ Regular:h13
"set guifont=CodingFontTobi:h16
"set guifont=ProggyClean
"set guifont=ProggySquare
"set guifont=Crisp
"set guifont=PixelCarnageMonoTT
set guifont=Consolas:h13
"set noantialias
"
"
" The opposite is 'set wrapscan' while searching for strings....
set nowrapscan
"
" You may want to turn off the beep sounds (if you want quite) with visual bell
set vb
" Source in your custom filetypes as given below -
" so $HOME/vim/myfiletypes.vim
" Make command line two lines high
"set ch=2
" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

"start selective import from http://amix.dk/vim/vimrc.html
"=========================================================

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

set history=700

"filetype on
filetype plugin indent on


set wildmenu
set ruler
set cmdheight=2
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" The opposite is set noignorecase
"set ignorecase
set ignorecase smartcase

" Switch on search pattern highlighting.
set hlsearch

set incsearch
set nolazyredraw

set magic

set showmatch
set mat=2

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

if has("gui_running")
  set guioptions-=T
  set t_Co=256
  set background=dark
  set nonu
  set transparency=0
elseif $ITERM_PROFILE != 'Default Light'
  set background=dark

  set nonu
endif
"light ones
"  colorscheme proton   "blue-grey on white
"  colorscheme zellner   "black on white red purple blue
"colorscheme pyte     "black on white yellow green red

"  colorscheme ir_black   "white on black, offwhite, green,  blue
" colorscheme vibrantink
"  colorscheme koehler
" colorscheme murphy
"  colorscheme peaksea
"  colorscheme torte
"colorscheme hornet
"colorscheme lucius
"colorscheme aldmeris
"let g:aldmeris_transparent = 1
"colorscheme synic
"blue one
"  colorscheme solarized
"  curl -o ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/fatih/molokai/master/colors/molokai.vim
" colorscheme molokai
"  curl -L -o ~/.vim/colors/carrot.vim http://www.vim.org/scripts/download_script.php?src_id=7602
 colorscheme carrot
" colorscheme gryftir
" colorscheme seti

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac

"Persistent undo
try
    if MySys() == "windows"
      set undodir=C:\Windows\Temp
    else
      set undodir=~/.vim_runtime/undodir
    endif

    set undofile
catch
endtry

" Highly recommended to set tab keys to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

set lbr
"set tw=500 "textwidth - might want 80

set autoindent "aka ai
set smartindent "aka si
set wrap "wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Useful on some European keyboards
map ½ $
imap ½ $
vmap ½ $
cmap ½ $


func! Cwd()
  let cwd = getcwd()
  return "e " . cwd 
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>
map <C-K> :bn<cr>
map <C-J> :bp<cr>

" Tab configuration
"map <leader>tn :tabnew<cr>
"map <leader>te :tabedit
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers 
try
  set switchbuf=usetab
  set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ %{fugitive#statusline()}\ \ Line:\ %l/%L:%c

" fugitive kills buftype for scp so I disabled it.
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ -\ \ Line:\ %l/%L:%c


function! CurDir()
    let curdir = substitute(getcwd(), '/Users/jwren/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vnoremap $1 <esc>`>a)<esc>`<i(<esc>
"vnoremap $2 <esc>`>a]<esc>`<i[<esc>
"vnoremap $3 <esc>`>a}<esc>`<i{<esc>
"vnoremap $$ <esc>`>a"<esc>`<i"<esc>
"vnoremap $q <esc>`>a'<esc>`<i'<esc>
"vnoremap $e <esc>`>a"<esc>`<i"<esc>
"
" Map auto complete of (, ", ', [
"inoremap $1 ()<esc>i
"inoremap $2 []<esc>i
"inoremap $3 {}<esc>i
"inoremap $4 {<esc>o}<esc>O
"inoremap $q ''<esc>i
"inoremap $e ""<esc>i
"inoremap $t <><esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
"map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
"JRW - these don't work in macvim, someday I'll figure them out
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"if mySys() == "mac"
"  nmap <D-j> <M-j>
"  nmap <D-k> <M-k>
"  vmap <D-j> <M-j>
"  vmap <D-k> <M-k>
"endif

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
"let g:bufExplorerDefaultHelp=0
"let g:bufExplorerShowRelativePath=1
"map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne = 2
"let g:miniBufExplModSelTarget = 0
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplVSplit = 25
"let g:miniBufExplSplitBelow=1
"
"let g:bufExplorerSortBy = "name"

"autocmd BufRead,BufNew :call UMiniBufExplorer

"map <leader>u :TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
"au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

"au FileType python inoremap <buffer> $r return
"au FileType python inoremap <buffer> $i import
"au FileType python inoremap <buffer> $p print
"au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

" see https://github.com/klen/python-mode
"let g:pymode_lint_write=0
"let g:pymode_run_key='R'
"let g:pymode=1
"let g:pymode_lint_checker="pyflakes,pep8"
let g:pymode_lint_checker="flake8"
let g:pymode_lint_onfly=1
" Override go-to.definition key shortcut to Ctrl-]
let g:pymode_rope_goto_definition_bind = "<C-]>"



""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
"let MRU_Max_Entries = 400
"map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated .bzr .git'
"set grepprg=/bin/grep\ -nH



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

map <leader>q :e ~/buffer<cr>
au BufRead,BufNewFile ~/buffer iab <buffer> xh1 ===========================================

map <leader>pp :setlocal paste!<cr>

map <leader>bb :cd ..<cr>

" end selective import from http://amix.dk/vim/vimrc.html
"========================================================

set cursorline

"remember current position
normal mz
  " I like highlighting strings inside C comments
  let c_comment_strings=1
  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif
  " Hide the mouse pointer while typing
  set mousehide
  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green
  " Constants are not underlined but have a slightly lighter background
  "hi Comment term=bold ctermfg=grey
  "highlight Normal guibg=grey90
  "highlight Cursor guibg=Green guifg=NONE
  "highlight NonText guibg=grey80
  "highlight Constant gui=NONE guibg=grey95
  "highlight Special gui=NONE guibg=grey95

set nocompatible
set backup

" Perl (syntax check, perldoc, run, clauses):
"map ,pc :!perl -wc %<ENTER>
" run perldoc on the word under the cursor
"map ,pd yiw:!perldoc <C-R>"<CR><ENTER>
"map ,pr :!perl %<ENTER>
"map ,ic oif ()<ENTER>{<ENTER><Tab><ENTER>}<Esc>3k4li
"map ,ec oelse<ENTER>{<ENTER><Tab><ENTER>}<Esc>2k$a
"map ,eic oelsif ()<ENTER>{<ENTER><Tab><ENTER>}<Esc>3k7li
"map ,fc ofor ()<ENTER>{<ENTER><Tab><ENTER>}<Esc>3k5li
"map ,wc owhile ()<ENTER>{<ENTER><Tab><ENTER>}<Esc>3k7li
"map ,sc osub  <ENTER>{<ENTER><Tab><ENTER>}<Esc>3k4li
"map ,sl o    my $self = shift;<Esc>
"map ,ml o    my () = @_;<Esc>5hi
" Go to the named function
"map gx yiw/^sub\s\+<C-R>"<CR>

" quick buffer switch ex: 
nnoremap  \  <C-^>

" Visual Basic.NET
au BufNewFile,BufRead *.vb			setf vb
au BufNewFile,BufRead *.boo			setf boo

set viminfo='200,\"50,:100 " read/write a .viminfo file, don't store more than
"                        " 50 lines of registers

"helptags ~/.vim/doc

if has("gui_running")
	highlight SpellBad term=underline gui=undercurl guisp=Orange
endif

let s:default_path = escape(&path, '\ ') " store default value of 'path'

" Always add the current file's directory to the path and tags list if not
" already there. Add it to the beginning to speed up searches.
autocmd BufRead *
      \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
      \ exec "set path-=".s:tempPath |
      \ exec "set path-=".s:default_path |
      \ exec "set path^=".s:tempPath |
      \ exec "set path^=".s:default_path
set tags=tags;/

"set foldenable=off "zi
set foldmethod=indent
set foldminlines=6 "fml
set foldlevel=4
set foldnestmax=1
set foldopen=all

" supertab
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"FU SP! autocmd FileType php set noexpandtab

"let g:SuperTabDefaultCompletionType = "context"
"set completeopt=menuone,longest,preview

set noerrorbells

set number

"autocmd VimEnter * autocmd WinEnter * let w:created=1
"autocmd VimEnter * let w:created=1
"autocmd WinEnter * if !exists('w:created') | let w:m1=matchadd('LineProximity', '\%<81v.\%>75v', -1) | endif
"autocmd WinEnter * if !exists('w:created') | let w:m2=matchadd('LineOverflow', '\%>80v.\+', -1) | endif

highlight ExtraWhitespace2 ctermbg=red ctermfg=white guibg=red | match ExtraWhitespace2 /\s\+$\| \+\ze\t/

"see above
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" source: http://vim.wikia.com/wiki/VimTip102
" Let <Tab> do all the autocompletion
function! Smart_TabComplete()
	let line = getline('.') 					" curline
	let substr = strpart(line, -1, col('.'))	" from start to cursor
	let substr = matchstr(substr, "[^ \t]*$")	" word till cursor
	if (strlen(substr)==0)						" nothing to match on empty string
		return "\<tab>"
	endif
	let has_period = match(substr, '\.') != -1	" position of period, if any
	let has_slash = match(substr, '\/') != -1	" position of slash, if any
	if (!has_period && !has_slash)
		return "\<C-X>\<C-P>"					" existing text matching
	elseif ( has_slash )
		return "\<C-X>\<C-F>"					" file matching
	else
		return "\<C-X>\<C-O>"					" plugin matching
	endif
endfunction
inoremap <tab> <c-r>=Smart_TabComplete()<CR>

"let g:pyflakes_use_quickfix = 0
"autocmd BufNewFile,BufRead *.py compiler nose
"let g:syntastic_python_checker = 'pyflakes'

py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

"or just use the * register:
"set clipboard=unnamedplus

"set nolist "i will turn it on if i want it
"set lcs=tab:>-
"set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅

"highlight lines over 80col
"23456789012345678901234567890123456789012345678901234567890123456789012345678901234
"highlight OverLength ctermbg=red ctermfg=white guibg=red | match OverLength /\%81v.*/

let tlist_pyrex_settings='python;c:classe;m:memder;f:function'
au BufNewFile,BufRead *.pxi			setf pyrex

" restore cursor pos
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set rtp+=/usr/local/Cellar/go/1.3/libexec/misc/vim

"https://github.com/fatih/vim-go
"g:go_disable_autoinstall = 1

set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set rtp^=$HOME/.vim/bundle/ctrlp.vim

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

"from vim-go
au FileType go nmap <Leader>i <Plug>(go-info)
"au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gd <Plug>(go-def)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>s <Plug>(go-implements)
au FileType go nmap <leader>e <Plug>(go-rename)
let g:go_fmt_command = "goimports"


"vim-go works with ultisnips - https://github.com/sirver/ultisnips
"let g:UltiSnipsExpandTrigger="<shift-tab>"

"neo requires lua
"let g:neocomplete#enable_at_startup = 1

let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
au FileType go nmap <Leader>tb :TagbarToggle<CR>

"TODO JRW add \cgpl, \cagpl, \clgpl with completion for canonical copyrights
au FileType go nmap <leader>cgpl i// Copyright 2014 Canonical Ltd.  // Licensed under the GPLv3, see LICENCE file for details.
au FileType go nmap <leader>cagpl i// Copyright 2014 Canonical Ltd.  // Licensed under the AGPLv3, see LICENCE file for details.
au FileType go nmap <leader>clgpl i// Copyright 2014 Canonical Ltd.  // Licensed under the LGPLv3, see LICENCE file for details.
au FileType go map ,il o// Copyright 2014 Canonical Ltd.  // Licensed under the LGPLv3, see LICENCE file for details.

setlocal spell spelllang=en_us
set bdir=~/tmp,~/

" Mark Down Preview use :Mdp
function! Mdp()
    write! /tmp/vim-markdown-preview
    "call system('markdown /tmp/vim-markdown-preview > /tmp/vim-markdown-preview.html')
    call system('VIRTUAL_ENV=/home/jrwren/venv ~/venv/bin/grip /tmp/vim-markdown-preview --export /tmp/vim-markdown-preview.html')
    call system('open /tmp/vim-markdown-preview.html')
endfunction
command! -nargs=0 Mdp call Mdp()

" syntastic recommends
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_python_checker = 0
