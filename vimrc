syntax on
filetype plugin indent on
set nocompatible

set number
set relativenumber
set cursorline

set ignorecase
set smartcase
set incsearch
set hlsearch
nmap <space><cr> :nohl<cr>

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
au FileType go setlocal noexpandtab

set clipboard^=unnamed,unnamedplus

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs 
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'pangloss/vim-javascript'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'francoiscabrol/ranger.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'lambdalisue/suda.vim'
Plug 'ap/vim-buftabline'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'cherrry/soong.vim'
Plug 'gburca/vim-logcat'
Plug 'bfrg/vim-cpp-modern'
Plug 'udalov/kotlin-vim'
call plug#end()

colorscheme dracula
set termguicolors

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END


autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)


set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
