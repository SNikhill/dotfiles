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
"   ---- plenary (required by telescope)
"   ---- telescope
"   -- Code Assistance
"   --- (Like, linter support, code completion, etc.)
"   ---- deoplete.nvim
"   ---- Gutentags
"   ---- Asynchronous Lint Engine
"
syntax on
set number relativenumber
set tabstop=4
set shiftwidth=4
set textwidth=80
set updatetime=200
set cursorline

" Disabling `netrw`
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" Showing `intro` on Vim Startup
autocmd VimEnter * intro

" signcolumn needs to be visible for gitgutter stuff
autocmd BufRead,BufNewFile * set signcolumn=yes
autocmd FileType tagbar,nerdtree set signcolumn=no
" Show linenumbers in the NERDTree explorer
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

"-- VIMRC
"---- Opening VIMRC in the first tab
nnoremap <leader>ev :tabnew $MYVIMRC<CR> :tabmove 0 <CR>
"---- SOURCING INIT.vim/VIMRC
nnoremap <leader>sv :source $MYVIMRC<CR>

"-- Pathogen Config
execute pathogen#infect()

"-- vim-airline Config
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"-- Asynchronous Lint Engine Config
"---- Fixers
let common_js_fixers = ['prettier', 'eslint']

"----- (I don't like the multiline `\` syntax for dictionary)
let g:ale_fixers = {}
let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
let g:ale_fixers['javascript'] = common_js_fixers
let g:ale_fixers['javascript.jsx'] = common_js_fixers
let g:ale_fixers['typescript'] = common_js_fixers
let g:ale_fixers['typescriptreact'] = common_js_fixers
let g:ale_fixers['html'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']

let g:ale_fix_on_save = 1

"---- Keybinds
nnoremap <leader>gg :ALEFix<CR>

if has('nvim')
	"-- Telescope Config
	"---- Keybinds
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>

	"-- Deoplete Config
	let g:deoplete#enable_at_startup = 0
	"---- Enable Deoplete when entering the Insert Mode
	autocmd InsertEnter * call deoplete#enable()
endif

"-- Themeing/Color Stuff
"---- background=dark is required for some reason
set background=dark
" let g:airline_theme = 'material'
" let g:material_theme_style = 'palenight'
if has('termguicolors')
	set termguicolors
endif
colorscheme github_dark

"-- NERDTree Config
"---- Prevent NERDTree from highjacking `netrw` command
let g:NERDTreeHijackNetrw = 0
"---- Keybinds
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

"---- Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
