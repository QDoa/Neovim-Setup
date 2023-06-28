" File: liberty.vim
" Author: Michael van der Kamp
" Description: Vim syntax file
" Last Modified: September 08, 2019
" Original: Peter Debacker "pdback@imec.be"
" https://github.com/peter-d/dotfiles/blob/master/.vim/syntax/liberty.vim

" I reduced the original rather long and difficult to maintain series of
" keywords (which wasn't always accurate) down to a few simple regexes. They may
" not work all the time, but they should be good most of the time, at least
" judging from the liberty files I've seen.

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

setlocal iskeyword=@,48-57,_

syn match libertyValue /\<[[:keyword:].]\+\>/

" Numbers, all with arbitrary alphabetical suffixes
"==========================================================
" Note that the two separate definitions should allow for faster match
" failures by being more explicit about the first characters.
"==========================================================
" Simpler number, for inside of strings
syn match libertyPlainNumber "[-+]\=\(\d\+\(\.\d*\)\=\|\.\d\+\)\(e[-+]\=\d\+\)\=" contained

"integer or floating point number with optional exponent
syn match libertyNumber  "[-+]\=\d\+\(\.\d*\)\=\(e[-+]\=\d\+\)\=[[:alpha:]]*"

"floating point number, starting with a dot, optional exponent
syn match libertyNumber  "[-+]\=\.\d\+\(e[-+]\=\d\+\)\=[[:alpha:]]*"

" Top level stuff
"==========================================================
syn match libertySimpleAttr /\<\zs\k\+\ze\s*:/
syn match libertyComplexAttr /\<\zs\k\+\ze\s*(/
syn match libertyGroup /\<\zs\k\+\ze\s*(.*)\s*{/

syn region libertyGroupRegion start="(" end=")\s*{" oneline keepend contains=libertyValue, libertyString

" Misc
"=====
syn match   libertyWrapLineOperator       "\\$"
syn region  libertyString       start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=libertyPlainNumber, libertyWrapLineOperator
syn region  libertyComment      start="/\*" end="\*/" contains=libertyTodo
syn keyword libertyTodo         TODO contained

" These syncing methods should guarantee correct highlighting in all
" circumstances, very quickly.
syntax sync ccomment libertyComment
syntax sync match grouphere "\(}\|)\|;\)\s*$"

" Syntax folding
"==========================================================
" To enable some useful folding on groups, use the following line (uncommented,
" preferably in your .vimrc).
"==========================================================
" autocmd! FileType liberty setlocal foldmethod=marker
"                       \ | setlocal foldmarker={,}

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_liberty_syntax_inits")
  if version < 508
    let did_liberty_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink libertyValue            Define
  HiLink libertyTodo             Todo
  HiLink libertyWrapLineOperator Special
  HiLink libertyPlainNumber      libertyNumber
  HiLink libertyNumber           Number
  HiLink libertyComment          Comment
  HiLink libertyString           String
  HiLink libertyGroup            Function
  HiLink libertySimpleAttr       Type
  HiLink libertyComplexAttr      Statement

  delcommand HiLink
endif

let b:current_syntax = "liberty"

