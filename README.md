# Dumb File Manager

This is the *Dumb File Manager*

## How Does it Work?

There is a *C* program called `dfm_screen.c` it is responsible for der display part.
`dfm_screen` takes the following arguments in exacly this order:

```
dfm_screen [title] [col 1] [col 2] [col 3]
```

It displays the text you've given it and after a keypress it exits and prints the pressed key to *stdout*.

But to use *dfm* you do not use `dfm_screen` directly.
It is called from the `dfm` Shell-Script.
The script uses some simple `ls` and other commands to list your files.

## How to Install?

Simply type:

```
sudo make install
```

## Ahh I want to get rid of it

To remove this rubish enter:
```
sudo make uninstall
```
