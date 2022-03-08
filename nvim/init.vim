"-- Foreword
" This is my vim config. NeoVim config to be precise. It may work with Vim8
" although, I never tested the same and frankly don't even know the difference
" that NeoVim produces since, I haven't really used Vim that much. I started
" with NeoVim.
" - Plugin Manager: Pathogen
"   -- Basic Plugins:
"   ---- NERDTree
"   ---- vim-airline
"   ---- vim-colorschemes
"   ---- deoplete.nvim
"   -- Code Productivity:
"   --- (Not exactly coding stuff but, the things that make programming more
"   productive. Like, Version Control Tools, Commenting Tools)
"	---- GitGutter
"   ---- tcomment
"   ---- plenary (required by telescope)
"   ---- telescope
"   -- Code Assistance:
"   --- (Like, linter support, code completion, etc.)
"   ---- deoplete.nvim
"   ---- Gutentags
"   ---- Asynchronous Lint Engine
"
syntax on
set autoread
set number relativenumber
set tabstop=4
set shiftwidth=4
set textwidth=80
set updatetime=100
set cursorline

" Disabling `netrw`
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
" Showing `intro` on Vim Startup
autocmd VimEnter * intro

autocmd FileType tagbar,nerdtree set signcolumn=no

let mapleader=","

"-- General
"---- Keybinds
noremap <C-z> <nop>
inoremap jk <esc>
inoremap <esc> <nop>

"----- disabling arrow keys
nnoremap <Up> <nop>
nnoremap <Right> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>

"-- Terminal
"---- Keybinds
"----- open terminal at the bottom
nnoremap <C-t> :bel split<CR> :terminal <CR>

"-- Clipboard
"--- Refer to :help registers
"---- Copying to System's Clipboard
vnoremap yy "+y<CR>
"---- Pasting from System's Clipboard
vnoremap pp "+p<CR>
nnoremap pp "+p<CR>

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

"-- gitgutter Config
"---- Keybinds
"----- (h => hunk)
nnoremap <leader>hp :GitGutterPreviewHunk<CR>
nnoremap <leader>hs :GitGutterStageHunk<CR>
nnoremap <leader>hu :GitGutterUndoHunk<CR>
nnoremap [h :GitGutterPrevHunk<CR>
nnoremap ]h :GitGutterNextHunk<CR>
"----- signcolumn needs to be visible for the symbols
autocmd BufRead,BufNewFile * set signcolumn=yes

"-- Asynchronous Lint Engine Config aka ale
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
let g:ale_fixers['xml'] = ['prettier']
let g:ale_fixers['css'] = ['prettier']
let g:ale_fixers['scss'] = ['prettier']
let g:ale_fixers['json'] = common_js_fixers
let g:ale_fixers['jsonc'] = common_js_fixers

let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1

"---- Keybinds
nnoremap <F2> :ALERename<CR>
nnoremap <F12> :ALEGoToDefinition<CR>
nnoremap <leader>gg :ALEFix<CR>

if has('nvim')
	"-- Telescope Config
	"---- Keybinds
	nnoremap <Space><Space> :Telescope find_files<CR>
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>

	"-- deoplete Config
	let g:deoplete#enable_at_startup = 0
	"---- Disable deoplete when in TelescopePrompt
	autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)
	"---- Enable deoplete when entering the Insert Mode
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
colorscheme molokai

"-- NERDTree Config
"---- Show linenumbers in the NERDTree explorer
autocmd FileType nerdtree set number relativenumber

"---- Prevent NERDTree from highjacking `netrw` command
let g:NERDTreeHijackNetrw = 0
"---- Keybinds
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeToggle<CR>

"---- Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
