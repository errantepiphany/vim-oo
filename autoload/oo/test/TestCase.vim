let s:Assert = g:oo#test#Assert#class
let s:TestCase = s:Assert.subclass('oo#test#TestCase')

let s:TestResult = g:oo#test#TestResult#class

function! s:TestCase.initialize(...) dict abort
    call function(s:Assert.initialize, self)()
    if a:0 == 0
        let self.case = self
    elseif type(a:1) == v:t_dict
        let self.case = extend(s:Assert.new(), a:1)
    endif
endfunction

function! s:TestCase.getCaseName() dict abort
    if has_key(self.case, 'name')
        return self.case.name
    elseif has_key(self.case, 'getClass') && type(self.case.getClass) == v:t_func
        return self.case.getClass().getName()
    else
        return '{}'
    endif
endfunction

function! s:TestCase.run() dict abort
    let l:result = s:TestResult.new()
    if has_key(self.case, 'setUp') && type(self.case.setUp) == v:t_func
        call self.case['setUp']()
    endif
    let l:keys = sort(keys(self.case))
    for l:key in l:keys
        if stridx(l:key, 'test') == 0
            let l:Test = self.case[l:key]
            if type(l:Test) == v:t_func
                try
                    call l:Test()
                catch /^[Aa]ssert.*/
                    call l:result.addFailure(self.getCaseName(), l:key, v:exception, v:throwpoint)
                catch /.*/
                    call l:result.addError(self.getCaseName(), l:key, v:exception, v:throwpoint)
                endtry
            endif
        endif
    endfor
    if has_key(self.case, 'tearDown') && type(self.case.tearDown) == v:t_func
        call self.case['tearDown']()
    endif
    return l:result
endfunction

let g:oo#test#TestCase#class = s:TestCase
