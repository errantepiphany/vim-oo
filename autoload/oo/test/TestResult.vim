let s:Object = g:oo#lang#Object#class
let s:TestResult = s:Object.subclass('oo#test#TestResult')

function! s:TestResult.initialize() dict abort
    call function(s:Object.initialize, self)()
endfunction

function! s:TestResult.addFailure(class, test, failure, throwpoint) dict abort
    echomsg printf('%s.%s -> failure: %s at %s', a:class, a:test, a:failure, a:throwpoint)
endfunction

function! s:TestResult.addError(class, test, error, throwpoint) dict abort
    echomsg printf('%s.%s -> error: %s at %s', a:class, a:test, a:error, a:throwpoint)
endfunction

let g:oo#test#TestResult#class = s:TestResult
