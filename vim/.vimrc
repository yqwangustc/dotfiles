set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-scripts/c.vim'
"Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'Lokaltog/vim-powerline'
"Plugin 'Valloric/YouCompleteMe', {'pinned': 1}
"Plugin 'basepi/vim-conque'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/perl-support.vim'
Plugin 'vim-scripts/pylint.vim'
"Plugin 'vim-latex/vim-latex'
"Plugin 'lyuts/vim-rtags'
Plugin 'tmhedberg/SimpylFold'
"Plugin 'vim-scripts/Conque-GDB'

call vundle#end()            " required
filetype plugin indent on    " required

" tab and indent 
set shiftwidth=2
set softtabstop=2
set expandtab
 
" syntax 
syntax on

" allow moving between lines  
set backspace=2
set whichwrap+=<,>,h,l,[,]
set hls

if has("gui_running")
    set guifont=Monaco:h18
    set lines=999 columns=9999
    if has("gui_photon")
        set guifont=Courier\ New:s18
    endif
endif

set term=xterm-256color

" wrapping at 80 
set textwidth=80
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=237 guibg=DarkGray

" fdm 
set fdm=syntax

" encoding UTF8 
set encoding=utf-8

" ========================================
"  plugin specified settings
"  =======================================
"  0. color scheme 
set t_Co=256
set background=dark
colorscheme molokai


set cursorline 
hi CursorLine ctermfg=NONE ctermbg=239 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
hi Search ctermfg=NONE ctermbg=243 cterm=bold guifg=NONE guibg=NONE gui=underline
"   1. taglist 
let Tlist_Show_One_File = 1           
let Tlist_Exit_OnlyWindow = 1        
let Tlist_Use_Right_Window = 1          


"   2. syntastic 
" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_compiler_options = "-std=c++11 -Wall -Wextra -Wpedantic -I ~/fbcode"
set statusline+=%#warningmsg#
set statusline+=%*

"   4. omni complete 
filetype plugin on
set omnifunc=syntaxcomplete#Complete
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" " automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview


"   6. auto insert C++ header gates
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . "_". gatename
  execute "normal! o#define " . "_". gatename . " "
  execute "normal! Go#endif /* " . "_" . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()


"   7.  mapping for ConqueTermVSplit 
nmap <Leader>b :ConqueTermVSplit bash<CR>

"   8. mapping for pyclewn 
nmap <Leader>p :Pyclewn<CR>:Cmapkeys<CR>

"   9. python autocmd 
au BufNewFile,BufRead *.py
    \ set tabstop=4     | 
    \ set softtabstop=4 |
    \ set shiftwidth=4  |
    \ set textwidth=79  |
    \ set expandtab     |
    \ set autoindent    |
    \ set fileformat=unix |
"highlight BadWhitespace ctermbg=red guibg=darkred
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp match BadWhitespace /\s\+$/
au BufNewFile *.py 0r ~/.vim/templates/python.py


