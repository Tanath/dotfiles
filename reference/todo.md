# Simple todo management & notes using Linux tools

Most of these tools can be installed on Windows too with [scoop](https://scoop.sh/) and/or [chocolatey](https://chocolatey.org/install).

There are many options for managing tasks & todo lists, and other notes. I would [argue, as others have, that plain text files are the best](https://www.youtube.com/watch?v=WgV6M1LyfNY).
Apps and services come and go. Sometimes they last a while, but eventually you need to move on. Unless you use plain text. Plain text always 
works, and has many other advantages. There are more tools and support for working with text than any other format. And if you use the right
tools, you don't even need to worry about missing rich text formatting like bold and italics - just use [markdown](https://commonmark.org/) and a good editor. 
There's a learning curve, but when it comes to editing text nothing beats Vim. Once you learn how to use it it makes complicated, time-consuming
edits easy. If you're going to be editing a lot of text, it's worth it to learn Vim. Once you do, it's a force multiplier that will save you 
more time than it takes, even if it doesn't seem that way at first. That's going down the rabbit hole though. You can do simple text-based todo 
management with or without Vim, but once you start defaulting to text you're better off using the best tools available to you. That means
tools like vim/nvim or emacs, rg (Ripgrep) or ag (Silver Searcher), locate, fzf, sed, etc. And [your notes should be free and open source](https://www.youtube.com/watch?v=XRpHIa-2XCE), 
using standard long-lasting formats. Tools used for this simple todo method include:
* zsh - Aliases and functions make things easier and more efficient, and most things are naturally done here.
* echo
* cat
* nl
* sed
* ripgrep
* vim-gtk - GTK version to enable copying to the system clipboard.
* plocate
* fzf

There are many options for task management, including advanced text-based tools like taskwarrior, but here I'll show a method for simple todo 
list management where all you need is commonly used & available Linux tools. First, you might want different lists for different projects &
subjects, so putting different files in different folders is a good idea. I use `.todo` files and the main one goes in `~/.todo`. If you end up
with .todo files scattered around, not to worry. You can find them all by piping `locate` to `fzf`. My zsh setup uses:

```sh
lf () { locate -i "$@" | fzf -m --tac +s }
```

If you want to insert the path into a command you're typing you can use backticks and tab-completion:

```sh
vim `lf todo`
```

<kbd>Tab</kbd> at the end triggers evaluation of `lf todo` and outputs the path you select in fzf.

To start, you can add tasks by echoing from the terminal:

```sh
echo 'delete me' >> .todo
```

I also have an alias in my zsh setup for checking the todo list:

```sh
alias t='cat .todo | less'
```

This will print the todo and exit `less` if it's less than a full screen, without clearing the screen.
After adding some tasks, next is deleting tasks. First we get a numbered list. You can do `nl .todo`, or with the 't' alias: `t|nl`.
Then we can delete a line, like #2 with `sed`:

```sh
sed -i 2d .todo
```

You can use any kind of format/syntax you want for your text files, and add or omit features, and the tools can support your method. Say you
want tagging to more easily find tasks:

```sh
echo '@testing: delete me' >> .todo
```

Search with ripgrep:

```sh
rg @test .todo
```

It gives you the line numbers it found it on, and if you have a big list you might want to jump directly there in vim, which you can do by 
telling it the line number: `vim .todo +22`. And deleting a line in vim is as simple as `dd`.

Another feature you might want to add is urgency and importance. I suggest putting 2 symbols at the beginning of your tasks to signify each. 
We should avoid characters likely to appear in the task which rules out the obvious '-=+' for low, medium, high. I'll use '<%>' since * might be
used for bullet points or other things, and is harder to search for, and % can just be spelled out if you want to use it. So a task which has
low urgency, low importance would look like `<< @testing: delete me`. You can then search on these indicators as well to find the most urgent
and/or important tasks first.

Another alias I added is:

```sh
alias vt='vim .todo'
```

So you can easily add, remove, edit, search, and go to tasks or notes from your terminal. There are advanced, in-depth tools like taskwarrior
with a learning curve if you want that, but IMO most of the time something simple like this is all you need.

You can also have your terminal easily accessible at a press of a button. Use `xfce4-terminal` and add a custom keyboard shortcut binding it to
<kbd>F12</kbd> with this command:

```sh
xfce4-terminal --fullscreen --drop-down
```

This will toggle it when you hit <kbd>F12</kbd> so it's always a button away, whatever you're doing.
