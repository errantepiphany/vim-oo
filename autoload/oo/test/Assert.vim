let s:Object = g:oo#lang#Object#class
let s:Assert = s:Object.subclass('oo#test#Assert')

" https://www.javadoc.io/static/junit/junit/3.8.2/index.html

function! s:Assert.initialize() dict abort
    call function(s:Object.initialize, self)()
endfunction

function! s:Assert.assertEquals(expected, actual) dict abort
    if a:expected !=# a:actual
        throw printf('assertEquals failed: expected [%s], actual [%s]', a:expected, a:actual)
    endif
endfunction

let g:oo#test#Assert#class = s:Assert
