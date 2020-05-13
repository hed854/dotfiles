# dotfiles

## Installation

**Linux:**

```
./install.sh /home/dir

```

**Windows:**

* You must have 7zip installed on your system

```
./install.ps1 "c:/home/dir" "c:/7zip.exe"

```

## Keyboard configuration (optional)

**Linux**

```
./install.sh /home/dir kb_type
```

`kb_type` accepted values:

* `iso_tkl` (default): small factor ISO AZERTY keyboard (no numpad)
* `ansi`: any factor ANSI keyboard (large left shift) 

**Windows**

For ANSI keyboard, use `kbpv60_lt_gt.ahk` with Auto Hotkey

