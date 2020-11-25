nmap <silent> <buffer> <Leader>h :ALEHover<CR>

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

" Use standard goto definition mapping
nnoremap <silent> gd :ALEGoToDefinition<CR>

" Switch to test file
nnoremap <silent> <Leader>et :AV<CR>
nnoremap <silent> <Leader>t :GolangTestFocused<CR>
nnoremap <silent> <Leader>ta :GolangTestCurrentPackage<CR>

" Autocomplete
inoremap <S-Tab> <C-x><C-o>

set foldmethod=syntax
