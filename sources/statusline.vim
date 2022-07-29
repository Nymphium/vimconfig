set statusline=[
set statusline+=File:\"%t%m\" " filename[modified?]
set statusline+=\|Type:\"%Y\" " filetype
set statusline+=\|Enc:\"%{(&fenc!=''?&fenc:&enc)}\" " file encoding
set statusline+=]
set statusline+=\ (%h%w\L%l\/%L\ C%v\ W%{win_getid()}\ B%n) " (current linenenumber)/(all linenumber) (nth character) (window id) (buffer number)
set laststatus=2
