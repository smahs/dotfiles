set rtp +=~/.vim

" Vim-plug ==================================
call plug#begin('~/.vim/plugged')

"" Utilities:
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'itchyny/lightline.vim'

"" Languages:
Plug 'fatih/vim-go'
Plug 'lervag/vimtex'
Plug 'vim-scripts/indentpython.vim'
Plug 'tell-k/vim-autopep8'
Plug 'elzr/vim-json'

"" Themes:
Plug 'mhartington/oceanic-next'

call plug#end()

" Vim Plug Eng ==============================


" Vim Setup =================================

"" Use mouse if available
if has('mouse')
    set mouse=a
endif

"" Use system clipboard - deps: pbcopy (Mac), xsel (Linux)
set clipboard=unnamedplus

"" Enable True Color:
"" if (has("termguicolors"))
""	set termguicolors
"" endif

"" Set Color Theme:
colorscheme OceanicNext

"" User UTF-8 fonts
set encoding=utf-8

"" Airline setup
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'

"" Popup Colors:
highlight Pmenu ctermfg=252 ctermbg=236

"" Show Statusline:
set laststatus=2

"" Hide Showline: (Since PowerLine Is Enabled)
set noshowmode

"" Generic Settings:

""" Tabstop:
set tabstop=4
set expandtab
set shiftwidth=4

""" Line Numbers:
set number

""" Code Folding:
set foldmethod=syntax
set foldcolumn=2
set foldlevel=99

"""" Folding Colors:
highlight FoldColumn ctermfg=252 ctermbg=236
highlight Folded ctermfg=White ctermbg=236 

""" Change Directory To CWD:
set autochdir

" Vim Setup End =================================


" Plugin Setup =================================

"" NERDTree:
map <F2> :NERDTreeToggle<CR>

"" TagBar:
map <F10> :TagbarToggle<CR>
let g:tagbar_width = 20

"" VimGo:
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

"" LightLine:
set encoding=utf-8
scriptencoding utf-8
let g:lightline = {
	\ 'colorscheme': 'Tomorrow_Night',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightLineFugitive',
    \   'readonly': 'LightLineReadonly',
    \   'modified': 'LightLineModified',
    \   'filename': 'LightLineFilename'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }

function! LightLineModified()
	if &filetype == "help"
		return ""
  	elseif &modified
    	return "+"
  	elseif &modifiable
    	return ""
  	else
    	return ""
  	endif
endfunction

function! LightLineReadonly()
  	if &filetype == "help"
    	return ""
  	elseif &readonly
    	return ""
  	else
    	return ""
  	endif
endfunction

function! LightLineFugitive()
  " return exists('*fugitive#head') ? fugitive#head() : ''
  	if exists("*fugitive#head")
    	let _ = fugitive#head()
    	return strlen(_) ? ' '._ : ''
  	endif
  	return ''
endfunction

function! LightLineFilename()
  	return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
		\ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       	\ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" Plugin Setup End ==============================


" Custom Settings =================================

"" Automating Pastetoggle:
"" https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
        set paste
        return ""
endfunction

"" Custom TabStops:

""" JavaScript And HTML:
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

""" JSON:
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

""" XML Folding:
let g:xml_syntax_folding=1

""" YAML Spacing:
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Custom Settings End =================================
