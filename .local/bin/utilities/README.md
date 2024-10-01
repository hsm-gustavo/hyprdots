# Shell Utilities

A collection of shell utilities that I use in my current system

## Screenshot tool

A simple screenshot tool that uses grim to capture the screen in a wayland compositor

### Dependencies

```bash
fuzzel          -       For the menu
grim            -       The screenshot app
slurp           -       To get user selection
wl-clipboard    -       To copy the screenshot to the clipboard
Any nerd font   -       For menu icons
```

### Usage

1. First make it executable

```bash
chmod +x screenshot.sh
```

2. Now you're ready to use

```bash
sh screenshot.sh [option]
```

You can also create an alias in your .bashrc

```bash
alias screenshot="sh screenshot.sh"
```

### Commands

Prints the help message

```bash
screenshot --help|-h|*
```

Takes a screenshot of the screen

```bash
screenshot --screen|-s
```

Takes a screenshot of the selected area

```bash
screenshot --area|-a
```

Takes a screenshot of the selected window

```bash
screenshot --window|-w
```

## Powermenu
A powermenu that uses fuzzel as frontend

### Dependencies
```
fuzzel          -       The frontend
A nerd font     -       Icons (in this script I use Jetbrains Mono Nerd Font)
```

### Usage

1. First make it executable

```bash
chmod +x powermenu.sh
```

2. Now you're ready to use

```bash
sh powermenu.sh
```

You can also create an alias in your .bashrc

```bash
alias power="sh powermenu.sh"
```
