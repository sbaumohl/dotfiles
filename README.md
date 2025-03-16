# Sam's `chezmoi` managed dotfiles for fedora kinoite

After experimenting with NixOS, I've determined it isn't for me. Now, I'm using Fedora Kinoite and managing my dotfiles with chezmoi. I'm keeping my dotfiles and important setup notes here.  

Some general config ideas/tips: https://fedoramagazine.org/how-i-customize-fedora-silverblue-and-fedora-kinoite/

Nvidia drivers/troubleshooting: https://docs.fedoraproject.org/en-US/fedora-kinoite/troubleshooting/

## Layered Packages 

- bat
- chromium
- code
- containerd.io
- dnf
- docker
- fastfetch
- fd
- fuzzel
- gettext
- gh
- git
- htop
- lua-lpeg
- lua5.1
- lua5.1-lpeg
- mozilla-openh264
- neovim
- niri
- openh264
- openssl
- plasma-wayland-protocols
- python3.9
- thunderbird
- tlp
- tlp-rdw
- tmux
- vlc-plugin-ffmpeg
- vlc-plugin-kde
- waybar
- zsh

## Other Programs

- [chezmoi](https://www.chezmoi.io/)
- [Starship](https://github.com/starship/starship)
- [Zed](https://zed.dev/)
- [Zen Browser](https://www.zen-browser.app/)
- [Ghostty](https://ghostty.org)

## Installing the h264 codec for web browsers

```bash
rpm-ostree override remove noopenh264 --install openh264 --install mozilla-openh264
```

## Installing Nvidia drivers
- Official Guide: https://rpmfusion.org/Howto/NVIDIA#OSTree_.28Silverblue.2FKinoite.2Fetc.29

