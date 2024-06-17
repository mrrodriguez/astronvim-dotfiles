function! RepeatChar(char, count)
  return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal i".RepeatChar(nr2char(getchar()), v:count1)<CR>
nnoremap S :<C-U>exec "normal a".RepeatChar(nr2char(getchar()), v:count1)<CR>

if exists('g:vscode')
    " Keep undo/redo lists in sync with VSCode
    nmap silent u Cmdcall VSCodeNotify('undo')CR
    nmap silent C-r Cmdcall VSCodeNotify('redo')CR
endif
