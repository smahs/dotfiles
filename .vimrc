" Dein Setup =================================

if &compatible
    set nocompatible               " Be iMproved
endif

set runtimepath+=/Users/smahs/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/Users/smahs/.vim/dein')
    call dein#begin('/Users/smahs/.vim/dein')

    " Let dein manage dein
    call dein#add('/Users/smahs/.vim/dein/repos/github.com/Shougo/dein.vim')

    " Plugins listing begin
    
    "" Utilities:
    call dein#add('tpope/vim-fugitive')
    call dein#add('scrooloose/nerdtree')
    call dein#add('majutsushi/tagbar')
    call dein#add('itchyny/lightline.vim')

    "" Languages:
    call dein#add('fatih/vim-go')
    call dein#add('lervag/vimtex')

    "" Themes:
    call dein#add('mhartington/oceanic-next')

    " Plugin listing end

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

"" Install enabled plugins on startup.
if dein#check_install()
  call dein#install()
endif

" Dein Setup End =================================

" Vim Setup =================================

"" Enable True Color:
if (has("termguicolors"))
    set termguicolors
endif

"" Set Color Theme:
colorscheme OceanicNext

"" Popup Colors:
highlight Pmenu ctermfg=252 ctermbg=236

"" Set Font:
set guifont=Inconsolata-g\ 12

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
let g:go_metalinter_autosave = 1
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

" Plugin Setup End =================================

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

""" XML Folding:
let g:xml_syntax_folding=1

" Custom Settings End =================================
