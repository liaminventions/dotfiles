# dotfiles
![](https://raw.githubusercontent.com/liaminventions/dotfiles/main/images/example.png)
![](https://raw.githubusercontent.com/liaminventions/dotfiles/main/images/eww_example1.png)

managed by [chezmoi](https://github.com/twpayne/chezmoi).

## keyboard layout:

![](https://raw.githubusercontent.com/liaminventions/dotfiles/main/layout.svg)

## etc

this repo contains an `etc` directory.

to copy this to `/etc`, run (while in clone dir)
```
sudo cp -r etc/* /etc
```
this directory has `etc/default/grub`, `mkinitcpio.conf`, and a getty login config.

now run the `hibernator` script (if you have swap set up.)

```
sudo ./hibernator
```

to apply changes, update grub
```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```
rebuild initramfs,
```
sudo mkinitcpio -P
```
and reboot.

# NOTES

## waybar fonts

`ttf-font-awesome` and `ttf-roboto-mono` are needed for waybar to show correctly.

also, if you have a smaller screen resolution, consider un-commenting the `padding-right` css def in `~/.config/waybar/style.css`

## nm-applet

you man want to disable annoying "connection activated" notifications.

those can be disabled with

```
gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"
gsettings set org.gnome.nm-applet disable-connected-notifications "true"
```

## cursor

to set the cursor, open `nwg-look` and go to `Mouse cursor` and set the theme to `Posy's Cursor 125%`.

## wf-recorder

be sure to select the correct audio source with `pavucontrol` when screen recording.

to do this, go to pavucontrol and to the "Recording" tab (while screen recording) and select the correct audio source.

for example:

![](https://raw.githubusercontent.com/liaminventions/dotfiles/main/images/pa.png)

also, you only have to do this once, the settings will save.
