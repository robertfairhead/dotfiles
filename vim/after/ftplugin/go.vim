nmap <silent> <buffer> <Leader>h : <C-u>call GOVIMHover()<CR>

" Set mappings to test files
let g:projectionist_heuristics = {
            \ '*.go': {
            \   '*.go': {
            \       'alternate': '{}_test.go',
            \       'type': 'source'
            \   },
            \   '*_test.go': {
            \       'alternate': '{}.go',
            \       'type': 'test'
            \   },
            \ }}

" Switch to test file
nnoremap <silent> <Leader>et :AV<CR>
nnoremap <silent> <Leader>t :GolangTestFocused<CR>
nnoremap <silent> <Leader>ta :GolangTestCurrentPackage<CR>

" Autocomplete
inoremap <S-Tab> <C-x><C-o>

set foldmethod=syntax
