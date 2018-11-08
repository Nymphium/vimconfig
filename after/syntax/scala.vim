function! s:high()
	hi link scalaBrac Special
	hi link scalaKeyword Operator
	hi link scalaKeywordModifier Operator
	hi link scalaKeyChar Operator
	hi link scalaFunction MoreFunction
endfunction

augroup ScalaColor
	autocmd!
	autocmd ColorScheme * call s:high()
augroup END

syn match scalaBrac /(\|)\|{\|}\|\[\|\]/

syn match scalaKeyChar /\(+\|\*\|-\|\/\|\\\|:\|>\|<\|\$\|=\)\+/
syn match scalaFunction "=>"
