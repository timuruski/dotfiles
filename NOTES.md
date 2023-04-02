# iTerm 2

To enable italic fonts with iTerm, run `tic -x xterm-256color-italic.terminfo`, then set terminal type to `xterm-256color-italic`.

[How to actually get italics and true colour to work in iTerm + tmux + vim](https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be)
[How to use SF Mono font in other apps](https://osxdaily.com/2018/01/07/use-sf-mono-font-mac/)
[Curly and colored underlines for iTerm2](https://gitlab.com/gnachman/iterm2/-/issues/6382)

Example terminfo file:
```
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
```

Then run `tic -x xterm-256color-italic.terminfo` to install.

# dnsmasq

Warning: Taking root:admin ownership of some dnsmasq paths:
  /usr/local/Cellar/dnsmasq/2.86/sbin
  /usr/local/Cellar/dnsmasq/2.86/sbin/dnsmasq
  /usr/local/opt/dnsmasq
  /usr/local/opt/dnsmasq/sbin
  /usr/local/var/homebrew/linked/dnsmasq
This will require manual removal of these paths using `sudo rm` on
brew upgrade/reinstall/uninstall.

Edit /usr/local/etc/dnsmasq.conf
