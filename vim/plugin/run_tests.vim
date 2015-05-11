" Run Tests plugin
" Extracted from @garybernhardt and pulled into a rough plugin
" Last Change: 23 July, 2013
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  " let in_app = match(current_file, '\<\(controllers\|models\|views\|helpers\|decorators\|services\)\>') != -1 
  let in_app = match(current_file, '\<\(controllers\|views\|helpers\|decorators\|services\)\>') != -1 
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    else
      let new_file = substitute(new_file, '^lib/', '', '')
    endif
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    else
      let new_file = 'lib/' . new_file
    end
  endif
  return new_file
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    write
    call ClearScreen()
    " silent !echo "\e[2J"
    if match(a:filename, '\.feature$') != -1
      if filereadable("script/features")
        exec ":!script/features " . a:filename
      else
        exec ":!cucumber " . a:filename
      end
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elsif executable("bin/rspec")
            exec ":!bin/rspec " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! ClearScreen()
    " Print enough lines to clear the screen
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(^_test\|\(.feature\|_spec.rb\)$\)') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

nnoremap <leader>a :call OpenTestAlternate()<cr>
nnoremap <leader>t :call RunTestFile()<cr>
nnoremap <leader>T :call RunNearestTest()<cr>
" nnoremap <leader>a :call RunTests('')<cr>
