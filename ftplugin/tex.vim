function! ZathuraOpenPdf()
	let fullPath = expand("%:p")
	let pdfFile = substitute(fullPath, ".tex", ".pdf", "")
	execute "silent !zathura '" . pdfFile . "' &"
endfunction

nnoremap <A-p> :call ZathuraOpenPdf()<CR>
