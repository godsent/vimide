"
" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vim/vimrc

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"solarized
syntax enable
se t_Co=256
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = 'high'
let g:solarized_termcolors=256
let g:syntastic_quiet_messages = { "regex": '\m.*reference to past scope.*' }
let g:syntastic_quiet_messages = { "regex": '\m.*interpreted as argument prefix.*' }
colorscheme solarized

"set viminfo='10,\"100,:20,%,n~/.viminfo

"open file at last position
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

"autointending
set autoindent

"always display status bar
set laststatus=2
"two spaces instead of TAB
set tabstop=2
set shiftwidth=2
set expandtab

"line number
set number

"highlight search
set hlsearch

"incrementing search
set incsearch

"mapping
map \zw :ZoomWin<CR>
map \tr :NERDTreeToggle<CR>
map \n \b

"vertical ruller function
highlight VRuller ctermbg=grey guibg=grey
function! PlaceRuller()
  if !exists("w:rullerPlaced")
    let w:rullerPlaced=0
  endif

  if w:rullerPlaced
    execute 'match'
    let w:rullerPlaced=0
  else
    execute 'match VRuller /\%'.virtcol('.').'v/'
     let w:rullerPlaced=1
  endif
endfunction
nnoremap <silent> <Leader>r : call PlaceRuller()<CR>

"trailing characters
autocmd BufWritePre * :%s/\s\+$//e

"vim-plug
"see https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/nerdtree'
Plug 'ervandew/supertab'
Plug 'vim-syntastic/syntastic'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-scripts/ZoomWin'
Plug 'yuttie/comfortable-motion.vim'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"let g:coc_global_extensions = ['coc-solargraph']
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"enable rubocop checker for ruby files
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_yaml_checkers=['yamlxs']

let g:comfortable_motion_no_default_key_mappings = 1
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"

" nmap <silent> gd <Plug>(coc-definition)
" nnoremap <silent> K :call <SID>show_coc_documentation()<CR>
"
" function! s:show_coc_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

" scroll coc popups if scrollable otherwise fast scrilling
"
nnoremap <silent> <C-j> :call comfortable_motion#flick(70)<CR>
nnoremap <silent> <C-k> :call comfortable_motion#flick(-70)<CR>
" nnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : ":call comfortable_motion#flick(70)<CR>"
" nnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : ":call comfortable_motion#flick(-70)<CR>"
