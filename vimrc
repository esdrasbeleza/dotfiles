"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/esdrasbeleza/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/esdrasbeleza/.vim/bundle')
  call dein#begin('/Users/esdrasbeleza/.vim/bundle')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/esdrasbeleza/.vim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('ctrlpvim/ctrlp.vim')
  call dein#add('miyakogi/conoline.vim')
  call dein#add('luochen1990/rainbow')
  call dein#add('fatih/vim-go')
  call dein#add('tmsvg/pear-tree')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts------------------------


" Show line number
set number
set cursorline

" Conoline sets a nice current line highlight
let g:conoline_auto_enable = 1

