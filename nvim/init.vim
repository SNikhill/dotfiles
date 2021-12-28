"-- Foreword
" This is my vim config. NeoVim config to be precise. It may work with Vim8
" although, I never tested the same and frankly don't even know the difference
" that NeoVim produces since, I haven't really used Vim that much. I started
" with NeoVim.
"
" - Plugin Manager: Pathogen
"   -- Basic Plugins:
"   ---- NERDTree
"   ---- vim-airline
"   ---- Material Theme
"   ---- deoplete.nvim
"   -- Code Productivity
"   --- (Not exactly coding stuff but, the things that make programming more 
"   productive. Like, Version Control Tools, Commenting Tools)
"	---- GitGutter
"   ---- tcomment
"   -- Code Assistance
"   --- (Like, linter support, code completion, etc.)
"   ---- deoplete.nvim
"   ---- Gutentags
"   ---- Asynchronous Lint Engine
"
set number relativenumber
syntax on
set tabstop=4
set shiftwidth=4
set textwidth=80

" signcolumn needs to be visible for gitgutter stuff
autocmd BufRead,BufNewFile * set signcolumn=yes
autocmd FileType tagbar,nerdtree set signcolumn=no
autocmd FileType nerdtree set number relativenumber

"-- Keybinds
let mapleader=","

"---- Disabling Arrow Keys
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <Up> <nop>
nnoremap <Right> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>

"---- Opening INIT.vim/VIMRC
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
"---- SOURCING INIT.vim/VIMRC
nnoremap <leader>sv :source $MYVIMRC<CR>

"-- Pathogen Config
execute pathogen#infect()

"-- Asynchronous Lint Engine Config
let b:ale_fixers = {
			\'*': ['remove_trailing_lines', 'trim_whitespace'],
			\'html': ['prettier'],
			\	'javascript': ['eslint', 'prettier'],
			\'typescript': ['eslint', 'prettier'],
			\}

"---- Keybinds
nnoremap <leader>gg :ALEFix<CR>

"-- Deoplete Config
if has('nvim')
	let g:deoplete#enable_at_startup = 0
	"---- Enable Deoplete when entering the Insert Mode
	autocmd InsertEnter * call deoplete#enable()
endif

"-- Themeing/Color Stuff
"---- background=dark is required for some reason
set background=dark
let g:airline_theme = 'material'
let g:material_theme_style = 'darker'
if has('termguicolors')
	set termguicolors
endif
colorscheme material

"-- NERDTree Config
"---- Keybinds
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"---- Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
