" Sets a highlight on column 80
if exists('+colorcolumn')
  setlocal colorcolumn=80
endif

nnoremap <silent> <leader>et :AV<cr>
nnoremap <silent> <leader>t :RunRubyFocusedTest<cr>
nnoremap <silent> <leader>tc :RunRubyFocusedContext<cr>
nnoremap <silent> <leader>ta :RunAllRubyTests<cr>

inoremap <S-Tab> <C-x><C-n>
