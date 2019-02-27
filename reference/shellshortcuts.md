# Misc
* You can run `echo $?` to get exit code of last command.

# Bash Shortcuts Quick Reference
* <kbd>Ctrl</kbd>+<kbd>a</kbd>        Move to the start of the line.
* <kbd>Ctrl</kbd>+<kbd>e</kbd>        Move to the end of the line.
* <kbd>Ctrl</kbd>+<kbd>b</kbd>        Move back one character.
* <kbd>Alt</kbd>+<kbd>b</kbd>         Move back one word.
* <kbd>Ctrl</kbd>+<kbd>f</kbd>        Move forward one character.
* <kbd>Alt</kbd>+<kbd>f</kbd>         Move forward one word.
* <kbd>Ctrl</kbd>+<kbd>]</kbd> <kbd>x</kbd>        Where x is any character, moves the cursor forward to the next occurrence of x.
* <kbd>Alt</kbd>+<kbd>Ctrl</kbd>+<kbd>]</kbd> <kbd>x</kbd> Where x is any character, moves cursor backwards to the previous occurrence of x.
* <kbd>Ctrl</kbd>+<kbd>u</kbd>        Delete from the cursor to the beginning of the line.
* <kbd>Ctrl</kbd>+<kbd>k</kbd>        Delete from the cursor to the end of the line.
* <kbd>Ctrl</kbd>+<kbd>w</kbd>        Delete from the cursor to the start of the word.
* <kbd>Esc</kbd>+<kbd>Del</kbd>     Delete previous word (may not work, instead try Esc followed by Backspace)
* <kbd>Ctrl</kbd>+<kbd>y</kbd>        Pastes text from the clipboard.
* <kbd>Ctrl</kbd>+<kbd>l</kbd>        Clear the screen leaving the current line at the top of the screen.
* <kbd>Ctrl</kbd>+<kbd>x</kbd> <kbd>Ctrl</kbd>+<kbd>u</kbd> Undo the last changes. <kbd>Ctrl</kbd>+<kbd>_</kbd> does the same.
* <kbd>Alt</kbd>+<kbd>r</kbd>         Undo all changes to the line.
* <kbd>Alt</kbd>+<kbd>Ctrl</kbd>+<kbd>e</kbd>    Expand command line.
* <kbd>Ctrl</kbd>+<kbd>r</kbd>        Incremental reverse search of history.
* <kbd>Alt</kbd>+<kbd>p</kbd>         Non-incremental reverse search of history.
* `!!`            Execute last command in history
* `!abc`          Execute last command in history beginning with abc
* `!abc:p`        Print last command in history beginning with abc
* `!n`            Execute nth command in history
* `!$`            Last argument of last command
* `!^`            First argument of last command
* `^abc^xyz`    Replace first occurrence of abc with xyz in last command and execute it
