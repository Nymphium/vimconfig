let my_scala_highlighted = 0

function! s:color()
  let my_scala_highlighted = 1
  hi link scalaBrac Bracket
  hi link scalaKeyword Operator
  hi link scalaKeywordModifier Operator
  hi link scalaKeyChar Operator
  hi link scalaFunction MoreFunction
endfunction

augroup ScalaColor
  autocmd!
  autocmd BufEnter *.scala,*.sbt
        \  if !my_scala_highlighted
        \|   call s:color()
        \| endif
  " autocmd BufWritePost *.scala,*.sbt
        " \  if !my_scala_highlighted
        " \|   call s:color()
        " \| endif
augroup END

syn match scalaBrac /(\|)\|{\|}\|\[\|\]/
syn match scalaFunction "=>"

syn match scalaKeyChar /\(+\|\*\|-\|\/\|\\\|:\|>\|<\|\$\|=\)\+/

" RE-highlight comments which from derekwyatt/vim-scala/syntax/scala.vim
syn region scalaMultilineComment start="/\*" end="\*/" contains=scalaMultilineComment,scalaDocLinks,scalaParameterAnnotation,scalaCommentAnnotation,scalaTodo,scalaCommentCodeBlock,@Spell keepend fold
syn match scalaTrailingComment "//.*$" contains=scalaTodo,@Spell

