execute pathogen#infect()

set number
set ruler
set title

set t_Co=256
syntax enable 
colorscheme bubblegum 

" fix tmux issue with background
:set t_ut=

" highlight inc search
set hlsearch
set incsearch

"This clears the 'last search pattern' by hitting return
nnoremap <CR> :noh<CR><CR>

" open new slip panes to right and bottom, which feels more natural
set splitbelow
set splitright

filetype plugin indent on
set ts=2 sw=2 et
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=#3A3A3A   ctermbg=237
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
hi IndentGuidesEven ctermbg=darkgrey
" let g:indent_guides_guide_size = 1

au BufNewFile,BufRead *.ejs set filetype=html

" Syntastic with jshint
let g:syntastic_javascript_checkers = ['jshint']
let g:indent_guides_enable_on_vim_startup = 1

function s:find_jshintrc(dir)
  let l:found = globpath(a:dir, '.jshintrc')
  if filereadable(l:found)
    return l:found
  endif

  let l:parent = fnamemodify(a:dir, ':h')
  if l:parent != a:dir
    return s:find_jshintrc(l:parent)
  endif

  return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
  let l:dir = expand('%:p:h')
  let l:jshintrc = s:find_jshintrc(l:dir)
  let g:syntastic_javascript_jshint_conf = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()

" Vim-Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '>'

" vim-gitgutter
let g:gitgutter_highlight_lines = 1
let g:gitgutter_realtime = 1

" vim-tagbar
nnoremap <silent><F3> :TagbarToggle<CR>
let g:tagbar_width = 30
let g:tagbar_autoclose = 1

" NERD-tree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
map <C-n> :NERDTreeToggle<CR>
nnoremap <S-tab> :bn<CR>
map <C-t> :tabnew<CR>

" spellchek for txt files
au BufRead *.txt setlocal spell

" make Gdiff to open shit vertically
set diffopt+=vertical
