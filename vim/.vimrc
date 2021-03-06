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
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/a.vim'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Valloric/YouCompleteMe', {'pinned': 1}
"Plugin 'basepi/vim-conque'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-scripts/perl-support.vim'
Plugin 'vim-scripts/pylint.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'lyuts/vim-rtags'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/Conque-GDB'

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

set term=screen-256color

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
"set t_Co=256
set background=dark
if has("gui_running")
  colorscheme desert
else
  colorscheme 256-grayvim
endif
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

"   3. cscope and tags 
if has("cscope")
    set csprg=/usr/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    endif 
    set csverb
endif                                                                                                                     
nmap <Leader>es :cs find s <C-R>=expand("<cword>")<CR><CR> " s for symbol 
nmap <Leader>eg :cs find g <C-R>=expand("<cword>")<CR><CR> " g for global definition 
nmap <Leader>ec :cs find c <C-R>=expand("<cword>")<CR><CR> " c for calls (all calls t o the function under cursor 
nmap <Leader>et :cs find t <C-R>=expand("<cword>")<CR><CR> " t for text 
nmap <Leader>ee :cs find e <C-R>=expand("<cword>")<CR><CR> " e for egrep 
nmap <Leader>ef :cs find f <C-R>=expand("<cfile>")<CR><CR> " f for filename 
nmap <Leader>ei :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR> "i for includes (find files that include the filename under cursor) 
nmap <Leader>ed :cs find d <C-R>=expand("<cword>")<CR><CR> " d for called (find functions that the current function calls ) 
 
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

"   5.  you comeplete me 
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_confirm_extra_conf = 0


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

" for latex, automatic generate begin end for word under cursor
map <C-B> YpkI\begin{<ESC>A}<ESC>jI\end{<ESC>A}<esc>kA

" for vim-latex 
" " TIP: if you write your \label's as \label{fig:something}, then if you
" " type in \ref{fig: and press <C-n> you will automatically cycle through
" " all the figure labels. Very useful!
set iskeyword+=:

" RTags
let g:rtagsUseDefaultMappings = 0
let g:rtagsJumpStackMaxSize = 2000
let g:rtagsUseLocationList = 0
noremap <C-T>. :call rtags#JumpTo()<CR>
noremap <C-T>b <C-o>
noremap <C-T>f :call rtags#FindRefs()<CR>
noremap <C-T>n :call rtags#FindRefsByName(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <C-T>s :call rtags#FindSymbols(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <C-T>r :call rtags#ReindexFile()<CR>

" syntastic
let g:syntastic_c_include_dirs = [ '~/fbsource/fbcode' ]


" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '!'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py"
