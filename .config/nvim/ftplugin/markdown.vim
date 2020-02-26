
" Format tables when you type ||
inoremap <buffer> <Bar><Bar> <Bar><Esc>:TableFormat<CR>:sil! norm f\|<CR>a

" Highlight long lines
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
match OverLength /\%>80v.*/

" Automatically insert a newline after 80 characters
set textwidth=79

" Enable conceal for formatting
set conceallevel=2

function! CountNotes()
    try
        redir => subscount
        silent %s/^- \[\d\+\]://gne
        redir END
        let result=matchstr(subscount, '\d\+')
        if result == ""
          let result="0"
        end
        let @z=result
        return result
    endtry
endfunction

inoremap <buffer> <silent> <C-x>n <Esc>mz:call CountNotes()<CR>`za[<Esc>"zpa]<Space><Esc>"zyF[f<Space>}o<Esc>c^-<Space><C-r>z:<Space>

nnoremap <buffer> <silent> <C-x>n mz:call CountNotes()<CR>`z"xdi["zP<C-x>/^\- \[<C-r>x\]:<CR>f[ldi["zP<C-X>`z
