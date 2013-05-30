"============================================================================
"File:        c.vim
"Description: Syntax checking plugin for syntastic.vim
"Maintainer:  Gregor Uhlenheuer <kongo2002 at gmail dot com>
"License:     This program is free software. It comes without any warranty,
"             to the extent permitted by applicable law. You can redistribute
"             it and/or modify it under the terms of the Do What The Fuck You
"             Want To Public License, Version 2, as published by Sam Hocevar.
"             See http://sam.zoy.org/wtfpl/COPYING for more details.
"
"============================================================================


if exists('g:loaded_syntastic_c_gcc_checker')
    finish
endif
let g:loaded_syntastic_c_gcc_checker = 1

if !exists('g:syntastic_c_compiler')
    let g:syntastic_c_compiler = 'gcc'
endif

function! SyntaxCheckers_c_gcc_IsAvailable()
    return executable(g:syntastic_c_compiler)
endfunction

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:syntastic_c_compiler_options')
    let g:syntastic_c_compiler_options = '-std=gnu99'
endif

if !exists('g:syntastic_c_config_file')
    let g:syntastic_c_config_file = '.syntastic_c_config'
endif

function! SyntaxCheckers_c_gcc_GetLocList()
    return syntastic#c#GetLocList('c', {
        \ 'errorformat':
        \     '%-G%f:%s:,' .
        \     '%-G%f:%l: %#error: %#(Each undeclared identifier is reported only%.%#,' .
        \     '%-G%f:%l: %#error: %#for each function it appears%.%#,' .
        \     '%-GIn file included%.%#,' .
        \     '%-G %#from %f:%l\,,' .
        \     '%f:%l:%c: %trror: %m,' .
        \     '%f:%l:%c: %tarning: %m,' .
        \     '%f:%l:%c: %m,' .
        \     '%f:%l: %trror: %m,' .
        \     '%f:%l: %tarning: %m,'.
        \     '%f:%l: %m',
        \ 'makeprg_main': '-x c -fsyntax-only',
        \ 'makeprg_headers': '-x c',
        \ 'headers_pattern': '\.h$' })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker({
    \ 'filetype': 'c',
    \ 'name': 'gcc'})

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: set et sts=4 sw=4:
