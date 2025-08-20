# Sam's `chezmoi` managed dotfiles for fedora kinoite

I'm using Fedora Kinoite and managing my dotfiles with chezmoi. I'm keeping my dotfiles and important setup notes here.  

Some general config ideas/tips: https://fedoramagazine.org/how-i-customize-fedora-silverblue-and-fedora-kinoite/

Nvidia drivers/troubleshooting: https://docs.fedoraproject.org/en-US/fedora-kinoite/troubleshooting/


## Other Programs

- [chezmoi](https://www.chezmoi.io/)
- [Starship](https://github.com/starship/starship)
- [Zed](https://zed.dev/)
- [Zen Browser](https://www.zen-browser.app/)

## Installing the h264 codec for web browsers

```bash
rpm-ostree override remove noopenh264 --install openh264 --install mozilla-openh264
```

## Installing Nvidia drivers
- Official Guide: https://rpmfusion.org/Howto/NVIDIA#OSTree_.28Silverblue.2FKinoite.2Fetc.29

