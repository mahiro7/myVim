call plug#begin()

  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " this is for auto complete, prettier and tslinting
  
  let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier']  " list of CoC extensions needed
  
  Plug 'jiangmiao/auto-pairs' "this will auto close ( [ {
  
  " these two plugins will add highlighting and indenting to JSX and TSX files.
  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  
"  Plug 'ryanoasis/vim-devicons'
"  Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/nerdtree'
  
  Plug 'w0rp/ale'

  Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
  
  Plug 'junegunn/fzf'

  Plug 'joshdick/onedark.vim'

  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme onedark

set number

set tabstop=2
set shiftwidth=2
set expandtab

set encoding=UTF-8
set fileencoding=UTF-8

set cursorcolumn
set cursorline

let NERDTreeWinSize=37

autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

let g:ale_fixers = {
 \ 'javascript': ['eslint', 'prettier']
 \ }
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
let g:ale_fix_on_save = 1

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

"nerdtree
" let NERDTreeShowHidden = 1
" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1
" let NERDTreeIgnore = []
" let NERDTreeStatusline = ''
" 
" "nerdtree-git-plugin
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ 'Ignored'   : '☒',
"     \ "Unknown"   : "?"
"     \ }

let mapleader="\<space>"
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <C-p> :Files<CR>

tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

noremap <Esc> <C-\><C-j>

set splitbelow

au BufEnter * if &buftype == 'terminal' | :startinsert | endif
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <C-j> :call OpenTerminal()<CR>
