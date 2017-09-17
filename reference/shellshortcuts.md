# Misc
You can run `echo $?` to get exit code of last command.

# Bash Shortcuts Quick Reference
Ctrl-a	 Move to the start of the line.
Ctrl-e	 Move to the end of the line.
Ctrl-b	 Move back one character.
Alt-b	 Move back one word.
Ctrl-f	 Move forward one character.
Alt-f	 Move forward one word.
Ctrl-] x	 Where x is any character, moves the cursor forward to the next occurrence of x.
Alt-Ctrl-] x	 Where x is any character, moves the cursor backwards to the previous occurrence of x.
Ctrl-u	 Delete from the cursor to the beginning of the line.
Ctrl-k	 Delete from the cursor to the end of the line.
Ctrl-w	 Delete from the cursor to the start of the word.
Esc-Del	 Delete previous word (may not work, instead try Esc followed by Backspace)
Ctrl-y	 Pastes text from the clipboard.
Ctrl-l	 Clear the screen leaving the current line at the top of the screen.
Ctrl-x Ctrl-u	 Undo the last changes. Ctrl-_ does the same
Alt-r	 Undo all changes to the line.
Alt-Ctrl-e	 Expand command line.
Ctrl-r	 Incremental reverse search of history.
Alt-p	 Non-incremental reverse search of history.
!!	 Execute last command in history
!abc	 Execute last command in history beginning with abc
!abc:p	 Print last command in history beginning with abc
!n	 Execute nth command in history
!$	 Last argument of last command
!^	 First argument of last command
`^abc^xyz`	 Replace first occurrence of abc with xyz in last command and execute it
