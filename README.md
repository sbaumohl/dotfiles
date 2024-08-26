# Sam's `chezmoi` managed dotfiles for fedora kinoite

I tried for a while to make a pure NixOS installation. But I've realized that is maybe not for me. So now I have a dotfile repo handled with chezmoi, a cli tool that handles some of the version control and setup of your dotfiles. These setup instructions are both notes for myself and tips on how to recreate my setup, if for some god forsaken reason you want to do that. 

https://fedoramagazine.org/how-i-customize-fedora-silverblue-and-fedora-kinoite/

## Layered Packages 

## Other Programs

- [chezmoi](https://www.chezmoi.io/)
- [zsh.zen](https://github.com/cybardev/zen.zsh)
- [Zed](https://zed.dev/)



## Installing the h264 codec for web browsers

```
rpm-ostree override remove noopenh264 --install openh264 --install mozilla-openh264
```
