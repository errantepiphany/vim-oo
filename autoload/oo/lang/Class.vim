let s:Class = { 'name': 'oo#lang#Class' }

let s:classes = { s:Class['name']: s:Class }

function! s:Class.forName(name) dict abort
    if !has_key(s:classes, a:name)
        let l:class = copy(self)
        let l:class.name = a:name
        call remove(l:class, 'forName')
        let s:classes[a:name] = l:class
    endif
    return s:classes[a:name]
endfunction

function! s:Class.getName() dict abort
    return self.name
endfunction

function! s:Class.toString() dict abort
    return 'class ' .. self.getName()
endfunction

let g:oo#lang#Class#class = s:Class
