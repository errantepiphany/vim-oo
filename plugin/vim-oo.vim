" Plugin Load --------------

if exists('g:vim_oo_loaded')
    finish
endif
let g:vim_oo_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

" Plugin Functions ---------

" Plugin Commands ----------

" Plugin Menu --------------

" Plugin Events ------------

" Plugin Mappings ----------

" Plugin Reset -------------

let &cpo = s:save_cpo
unlet s:save_cpo
