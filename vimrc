" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2015 Mar 24
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
"  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
  set undodir=$HOME/.vimundo/
  set undolevels=1000
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

set term=xterm-256color
if exists('$TMUX')
	set term=screen-256color
endif



"cscope 设置
set csprg=/usr/bin/cscope
set csto =0
set cst
set nocsverb
cs add $PWD/cscope.out
set csverb
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR> 		Find this C symbol
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR> 		Find this definition
"nmap <C-_>c :cs find d <C-R>=expand("<cword>")<CR><CR> 	Find functions called by this function
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR> 		Find functions calling this function
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR> 		Find this text string
"nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>		Find this egrep pattern
"nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>		Find this file
"nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR>		Find files #including this file
nmap <C-_>d :cs find a <C-R>=expand("<cword>")<CR><CR> 		Find places where this symbol is assigned a value



"设置ctags路径
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
"启动vim后自动打开taglist窗口
"let Tlist_Auto_Open = 1
"不同时显示多个文件的tag，仅显示一个
let Tlist_Show_One_File = 1
"taglist为最后一个窗口时，退出vim
let Tlist_Exit_OnlyWindow = 1
"taglist右侧
let Tlist_Use_Right_Window=1
nmap <F9> : TlistToggle<CR>
set tags+=/home/zj/rt-thread/tags
set tags=$PWD/tags
set tags+=/home/zj/Program/glibc/src/glibc-2.22/tags
set tags+=/usr/include/tags
"NERDTREE设置
let NERDTreeWinPos="left"
nmap <F7> : NERDTreeToggle<CR>
let NERDTreeWinSize="21"
let NERDTreeQuitOpen="1"


"编码
set fileencodings=utf-8,utf-8le,gb18030,gbk,gb2312,big5,utf-16,utf-16le
"显示行号
set nu
set belloff=all
"添加man窗口
:source $VIMRUNTIME/ftplugin/man.vim
nmap m :Man 3  <C-R>=expand("<cword>")<CR><CR>
"空格翻页
nmap <Space> <C-D>
nmap <F2> :zsh<CR>
nmap <F3> :!make<CR>
nmap <F4> :!make run<CR>
nmap <F5> :!make programe<CR>
nmap <F6> :!vifm .<CR>
nmap T :tabnew<CR>
set ts=4
set sw=4
set expandtab
%retab!
"set background=light
"siwtch 与 case对齐
set cino+=:2
"鼠标在编辑模式可以复制
set mouse=n

