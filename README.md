<div align="center">

# Dotfiles

![Version](https://img.shields.io/badge/version-latest-brightgreen)
![AwesomeWM](https://img.shields.io/badge/-awesomewm-blue)
![Wallpapers](https://img.shields.io/badge/-wallpapers-red)

</div>

## Chapters:

- [Gallery](#Gallery)
- [Before we start](#before-we-start)
- [Requirments](#Requirements)
  - [Required Packages](#required-packages)
  - [Things you might need](#things-you-might-need-recommended)
- [Installation](#Installation)
  - [AwesomeWM](#AwesomeWM)
- [Wallpapers](#Wallpapers)
- [Credits](#credits)

<hr />

## Gallery

![01](gallery/01.png)
![02](gallery/02.png)
![03](gallery/03.png)

## Before we start

By installing this configuration, I expect that you have a working **Arch Linux** installation (or any derivatives) with working Audio (**Pulseaudio**) and Networking (**NetworkManager**).

> A Terminal Emulator, a Browser, **Xorg** and a display manager of choice should be installed.

## Requirements

You may need some dependencies before installation for the configuration to work properly.

> You may be missing on some fonts, programs and other depenedencies. It is recommended that you install all the packages.

To completely replicate my setup, you first need to make sure you have these dependencies.

### Required Packages:
| Name | Package | Type | Description |
| ---- | ------- | ---- | ----------- |
| AwesomeWM | [awesome](https://archlinux.org/packages/community/x86_64/awesome/) | Program | My _Favorite_ Tiling Window Manager.
| Dmenu | [dmenu](https://archlinux.org/packages/community/x86_64/dmenu/) | Program | Our Run Prompt for launching programs.
| Picom | [picom-jonaburg-git<sup>AUR</sup>](https://aur.archlinux.org/packages/picom-jonaburg-git) | Program | X Compositor for transparency and shadows. |
| Alacritty | [alacritty](https://archlinux.org/packages/community/x86_64/alacritty/) | Program | My _Favorite_ Terminal Emulator. (You can install any terminal emulator alongside Alacritty)

### Things you might need (_Recommended_):
| Name | Package | Type | Description |
| ---- | ------- | ---- | ----------- |
| Nitrogen | [nitrogen](https://archlinux.org/packages/extra/x86_64/nitrogen/) | Program | A Program for setting wallpapers. (You can also use [feh](https://archlinux.org/packages/extra/x86_64/feh/)) |
JetBrains Mono | [nerd-fonts-jetbrain-mono<sup>AUR</sup>](https://aur.archlinux.org/packages/nerd-fonts-jetbrains-mono) | Font | The Font used for the AwesomeWM panel. |
| Gedit | [gedit](https://archlinux.org/packages/extra/x86_64/gedit/) | Program | Graphical Text Editor (I don't use it, but it happens to be in my configuration files; because this is the only _Proper_ Graphical Plain Text Editor I know. Don't install if you want.) |
| Neovim | [neovim](https://archlinux.org/packages/community/x86_64/neovim/) | Program | My Favorite Text Editor by far. (Replace with Vim, Emacs, Nano and Gedit if you want.) |
| Brave | [brave-bin<sup>AUR</sup>](https://aur.archlinux.org/packages/brave-bin) | Program | My Favorite Web Browser, an open-source Chromium-based web browser that is privacy-oriented. (Use Firefox, Vivaldi, Chromium or LibreWolf if you want.) |
| LX Appearance | [lxappearance](https://archlinux.org/packages/community/x86_64/lxappearance/) | Program | GTK Theme Manager, Look and Feel. Use it to change the GTK Themes. (Similar to GNOME-Tweaks) |
| Kripton GTK Theme | [kripton-theme-git<sup>AUR</sup>](https://aur.archlinux.org/packages/kripton-theme-git) | GTK Theme | Dark Githuby looking theme. Works very well with oomox-aesthetic-dark GTK Icon Theme. |
| Neofetch | [neofetch](https://archlinux.org/packages/community/any/neofetch/) | Program | Useless but cool.

<br />

## Installation

Now, for the installation. **Follow the steps carefully**.

### **Step 1:** Clone the Repository

First, clone the repository by running the `git clone` command:

```bash
$ cd ~
$ git clone https://github.com/techtycho/dotfiles
```

Now go to the new directory, it should be called `~/dotfiles`.

```bash
$ cd ~/dotfiles
```

### **Step 2:** Extract the Icon Theme

The Icon Theme we will be using is called oomox-aesthetic. Thanks to [ilham25](https://github.com/ilham25) for creating this awesome Icon Theme.

The Icon Theme is not present in the core repositories, nor the AUR. Instead, it is located in the `.icons/` directory in this repository. I made sure I included the Light and Dark themes.

The Icon Themes are just `.tar.xz` files. Go to the `.icons/` directory, then extract the files.

```bash
$ cd .icons/
$ tar -Jxvf oomox-aesthetic-dark.tar.xz
```

Extract the other file if you want the Light theme:

```bash
$ tar -Jxvf oomox-aesthetic-light.tar.xz
```

Then, move the two output directories to `/usr/share/icons/`, make sure you have `sudo` privellages.

```bash
$ sudo cp -r oomox-aesthetic-dark oomox-aesthetic-light /usr/share/icons/
```

Now delete unnecessary files:

```bash
$ rm -r oomox-aesthetic-* *.tar.xz
```

### **Step 3:** Configure Programs Indivually

Now you will see how to install the configuration to every program indivually.

> Each program will have its own section.

### AwesomeWM



<hr />

## Credits

Thanks to [ilham25](https://github.com/ilham25) for creating oomox-aesthetic icon theme.
