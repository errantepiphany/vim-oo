let s:Object = { 'class': g:oo#lang#Class#class.forName('oo#lang#Object') }

let s:instanceCounters = {}

function! s:Object.new(...) dict abort
    let l:this = copy(self)
    call function(l:this.initialize, a:000[0:a:0], l:this)()
    call remove(l:this, 'initialize')
    call remove(l:this, 'subclass')
    let l:tab = s:instanceCounters
    let l:key = self.class.name
    if !has_key(l:tab, l:key)
        let l:tab[l:key] = 0
    endif
    let l:this._instanceNumber = l:tab[l:key] + 1
    let l:tab[l:key] = l:this._instanceNumber
    return l:this
endfunction

function! s:Object.initialize() dict abort
    " no-op
endfunction

function! s:Object.subclass(name) dict abort
    return extend(copy(self), {'class': g:oo#lang#Class#class.forName(a:name)})
endfunction

function! s:Object.getClass() dict abort
    return self.class
endfunction

function! s:Object.toString() dict abort
    let l:str = ''
    let l:keys = sort(keys(self))
    for l:key in l:keys
        if l:key ==# 'class' || stridx(l:key, '_') == 0
            continue
        endif
        let l:Val = self[l:key]
        let l:type = type(l:Val)
        if l:type != v:t_func
            if strlen(l:str) != 0
                let l:str = l:str .. ','
            endif
            let l:str = l:str .. l:key .. '='
            if l:type == v:t_dict
                if has_key(l:Val, 'toString') && type(get(l:Val, 'toString')) == v:t_func
                    " TODO: provide an optional argument that I can pass which
                    "       can specify !recursive for other values of type
                    "       Object, thus helping prevent infinite circular
                    "       references
                    let l:str = l:str .. l:Val.toString()
                else
                    let l:str = l:str .. '{...}'
                endif
            elseif l:type == v:t_list
                let l:str = l:str .. '[...]'
            elseif l:type == v:t_string
                let l:str = l:str .. l:Val
            else
                let l:str = l:str .. string(l:Val)
            endif
        endif
    endfor
    return printf('%s@%s{%s}', self.class.name, self._instanceNumber, l:str)
endfunction

let g:oo#lang#Object#class = s:Object
