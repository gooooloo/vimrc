"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Amir Salihefendic — @amix3k
"       @gooooloo
"
"           https://github.com/amix/vimrc
"           https://github.com/gooooloo/vimrc
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ad-hoc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
filetype indent on
syntax enable 

set showmatch 
set mat=1 " 1 means 100 ms

set hlsearch
set incsearch 
set noignorecase

set so=4 " jk时上下边缘剩几行就开始滚动？
set number

set noundofile
set history=500

set encoding=utf8
set ffs=unix,dos,mac

set nobackup      " 不要 ～ 备份
set nowb          " 不要写时容灾 ～ 备份
set noswapfile    " 不要写时容灾 swp 备份

" For regular expressions turn magic on
" TODO: Do I need it?
" set magic


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline
set ruler
set cmdheight=1
set lazyredraw " 重放宏时暂停更新界面

set wildmenu
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set guioptions-=r " 不要滚动条
set guioptions-=R " 不要滚动条
set guioptions-=l " 不要滚动条
set guioptions-=L " 不要滚动条

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bells
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noerrorbells
set novisualbell
set t_vb=
set tm=500
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert " TODO: pick a colorscheme. maybe https://awesomeopensource.com/project/rakr/vim-one?
catch
endtry

if has("mac") || has("macunix")
    set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Set extra options when running in GUI mode
" TODO: need this on GVIM / MACVIM?
" if has("gui_running")
"     set guioptions-=T
"     set guioptions-=e
"     set t_Co=256
"     set guitablabel=%M\ %t
" endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 缩进、换行
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab    " 只在输入模式下生效。无论是否行首都能把输入的 TAB 替换成空格
set tabstop=4    " 一个 TAB 宽 4 个空格
set smarttab     " 在行首输入 TAB 时，语义上按输入一层缩进来处理
set shiftwidth=4 " 一个缩进宽 4 个空格

set wrap
set lbr     " 换行时不在单词中间换
set tw=78   " TODO: 似乎并没有太起作用？网上有说可能是因为被覆盖掉了 https://stackoverflow.com/a/5136998/3273620

set ai "Auto indent    " 如果上一行缩进来，输入下一行时自动对齐其缩进
" set si "Smart indent " TODO: 据说这个是在auto indent打开时，而且在写C代码时，遇到{的下一行，会自动再缩进一点点之类的。
                       " TODO: 但是我试的时候不生效。不知道为什么？先注释掉了。


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hid " http://www.mikewootc.com/wiki/tool/sw_develop/vim.html

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
set laststatus=2 " Always show the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c " Format the status line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins https://github.com/junegunn/vim-plug/wiki/tutorial
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'hotoo/pangu.vim'
Plug 'yianwillis/vimcdoc'
Plug 'gooooloo/smartim'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin hotoo/pangu.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

" ad-hoc settings
map <silent> <leader><cr> :noh<cr>
map <leader>cd :cd %:p:h<cr>:pwd<cr>
map 0 ^
"map <space> /
nmap <leader>ww :w<cr>
" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm " Remove the Windows ^M

" window related
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" buffer related
map <leader>bd :Bclose<cr>:tabclose<cr>gT " 删除当前 buffer
map <leader>ba :bufdo bd<cr>              " 删除所有 buffer
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>

" tab related
map <leader>tc :tabclose<cr> " 关闭本 tab
map <leader>to :tabonly<cr>  " 关闭其他 tab
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/ " Opens a new tab with the current buffer's path 
                                                   " Super useful when editing files in the same directory
nmap <Leader>tt :exe "tabn ".g:lasttab<CR>         " Let 'tt' toggle between this and the last accessed tab

" spell realted
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

cno $q <C-\>eDeleteTillSlash()<cr> " $q is super useful when browsing on the command line
                                   " it deletes everything until the last slash 

cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" vimrc related
cnoremap <leader>rc e ~/.vimrc<CR>

" for plugin gooooloo/smartim
nmap <silent> <leader>3 :let g:smartim_enter_as_chinese=1<CR>
imap <silent> <leader>3 <esc><leader>3a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
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

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc
