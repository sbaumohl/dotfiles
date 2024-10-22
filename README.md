# Sam's `chezmoi` managed dotfiles for fedora kinoite

After experimenting with NixOS, I've determined it isn't for me. Now, I'm using Fedora Kinoite and managing my dotfiles with chezmoi. I'm keeping my dotfiles and important setup notes here.  


Some general config ideas/tips: https://fedoramagazine.org/how-i-customize-fedora-silverblue-and-fedora-kinoite/

Nvidia drivers/troubleshooting: https://docs.fedoraproject.org/en-US/fedora-kinoite/troubleshooting/

## Layered Packages 

- chromium
- code
- containerd.io
- dnf
- docker-buildx-plugin
- docker-ce
- docker-ce-cli
- docker-compose-plugin
- extra-cmake-modules
- fastfetch
- gettext
- gh
- git
- htop
- java-17-openjdk
- lua-lpeg
- lua5.1
- lua5.1-lpeg
- luarocks
- mozilla-openh264
- neovim
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
- zsh

## Other Programs

- [chezmoi](https://www.chezmoi.io/)
- [zsh.zen](https://github.com/cybardev/zen.zsh)
- [Zed](https://zed.dev/)
- [Zen Browser](https://www.zen-browser.app/)


## Installing the h264 codec for web browsers

```bash
rpm-ostree override remove noopenh264 --install openh264 --install mozilla-openh264
```
