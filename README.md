<div align="center">

# Dotfiles

![Version](https://img.shields.io/badge/version-latest-brightgreen)
![AwesomeWM](https://img.shields.io/badge/-awesomewm-blue)
![Wallpapers](https://img.shields.io/badge/-wallpapers-red)

</div>

## Chapters:

- [Gallery](#-gallery)
- [Before we start](#before-we-start)
- [Requirments](#requirements)
  - [Required Packages](#required-packages)
  - [Things you might need](#things-you-might-need-recommended)
- [Installation](#installation)
  - [AwesomeWM](#awesomewm)
- [Wallpapers](#-wallpapers)
- [Credits](#credits)

<hr />

## 🎨 Gallery

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
| Hack | [nerd-fonts-hack<sup>AUR</sup>](https://aur.archlinux.org/packages/nerd-fonts-hack) | Font | The font used for the AwesomeWM panel and the Terminal.
| Gedit | [gedit](https://archlinux.org/packages/extra/x86_64/gedit/) | Program | Graphical Text Editor (I don't use it, but it happens to be in my configuration files; because this is the only _Proper_ Graphical Plain Text Editor I know. Don't install if you want.) |
| Neovim | [neovim](https://archlinux.org/packages/community/x86_64/neovim/) | Program | My Favorite Text Editor by far. (Replace with Vim, Emacs, Nano and Gedit if you want.) |
| Brave | [brave-bin<sup>AUR</sup>](https://aur.archlinux.org/packages/brave-bin) | Program | My Favorite Web Browser, an open-source Chromium-based web browser that is privacy-oriented. (Use Firefox, Vivaldi, Chromium or LibreWolf if you want.) |
| LX Appearance | [lxappearance](https://archlinux.org/packages/community/x86_64/lxappearance/) | Program | GTK Theme Manager, Look and Feel. Use it to change the GTK Themes. (Similar to GNOME-Tweaks) |
| Kripton GTK Theme | [kripton-theme-git<sup>AUR</sup>](https://aur.archlinux.org/packages/kripton-theme-git) | GTK Theme | Dark Githuby looking theme. Works very well with oomox-aesthetic-dark GTK Icon Theme. |
| Neofetch | [neofetch](https://archlinux.org/packages/community/any/neofetch/) | Program | Useless but cool.

> If you want to install the required packages automatically, then use the `pkg-install.sh` script.

<br />

## Installation

Now, for the installation. **Follow the steps carefully**.

### There are two ways to install

There are two ways to install: **manual installation** (Safer) and **installation script** (Faster).

> NOTE: The installation script may contain some bugs, so it is not a wise option for someone who doesn't know much about Linux, don't know how to fix problems
> and don't know what are the commands being run. I recommend reading the script and knowing exactly what it will do to your system.

To install via **installation script**, install the latest release of the installation script (using GitHub).

After you've got the script, give it execute privilages, type:

```bash
sudo chmod a+x install.sh
```

Then run it (I recommend reading it first), type:

```bash
./install.sh
```

If you want to install manually, **Follow the steps carefully**:

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

To apply the theme, open `lxappearance` and go to the Icon Theme tab, choose `oomox-aesthetic-dark` or `oomox-aesthetic-light`.

> We assume that you already have some kind of graphical environment (A Desktop Environment or a standalone Window Manager). If you are not, then
> please install one (assuming that you have Xorg and Xorg-xinit), install AwesomeWM and add it to your xinit config or just use a Display Manager. Go to 
> the ArchWiki.

### **Step 3:** Configure Programs Indivually

Now you will see how to install the configuration to every program indivually.

> Each program will have its own section.

### AwesomeWM

First, make sure you read a little bit about AwesomeWM in the [Arch Wiki](https://wiki.archlinux.org/title/awesome). The Wiki will tell you to create a directory at `~/.config/awesome/`. Finish the Installation and Configuraton guide written by the Arch Wiki.

**First**, create a **backup**; you don't want to trash all your progress. So you won't cry after installing my dotfiles and finding out that they don't look as you expected them to be. At this point, there is no returning back.

Create a backup directory, it will be in `~/config/awesome_old`:

```bash
$ cd ~/.config/
$ mv awesome awesome_old
```

If you want to return back to your old config, just do:

```bash
$ cd ~/.config/
$ rm -r awesome/
$ mv awesome_old awesome
```

Now for the real installation.

```bash
$ cd ~/dotfiles/.config/
$ mv awesome ~/.config/
```

And that's it, you've successfully installed my configuration of AwesomeWM. Have Fun!

## 🖼 Wallpapers

All my wallpapers are available in the `wallpapers` directory in this repository. Expecting that you installed my AwesomeWM configuration, open the program `nitrogen` by pressing `Super+P` to open `dmenu` (You have to install these two programs, go to [Requirements](#requirements)). After you've opened `dmenu`, a bar at the top will pop up, just type `"nitrogen"`, press `Enter`, and `nitrogen` will open.

After you've opened `nitrogen`, go to the bottom right, you should find a button called `Preferences`, click on it. A pop-up window will appear, there are three sections, go to the last section, which is called `Directories`. There are two buttons in this section, `Add` and `Delete`. Click `Add`, and choose the wallpapers' directory, it should be `~/dotfiles/wallpapers/`. After you've done this step, press `Ok`. A list of wallpapers should appear, click on one of them and click `Apply`.

<hr />

## Credits

Thanks to [ilham25](https://github.com/ilham25) for creating oomox-aesthetic icon theme.
