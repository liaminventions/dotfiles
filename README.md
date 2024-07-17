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
this directory has `etc/default/grub`, `mkinitcpio.conf`, and a getty login dropin file.

now run the `hibernator` script (if you have swap set up.)

```
sudo ./hibernator
```

to apply changes, update grub with

`sudo grub-mkconfig -o /boot/grub/grub.cfg` or `sudo update-grub`

rebuild initramfs,
```
sudo mkinitcpio -P
```
and reboot.

# NOTES

## usr

there is a `usr` directory here aswell. this has a script (`lidswitch.sh`) in it that re-enables the lid switch after hibernating

this fixes an issue where systemd suspends instead of hibernating if you close the lid right before `systemctl hibernate` is ran (in `~/.config/hypr/scripts/hibernate`) 

## waybar fonts

`ttf-font-awesome`, `ttf-roboto-mono` and `ttf-roboto-mono-nerd` are needed for waybar to show correctly.

also, if you have a smaller screen resolution, consider adjusting the `padding-right` css defs in `~/.config/waybar/style.css`

also `noto-fonts` (mostly) is used everywhere else

## nm-applet

you might want to disable annoying "connection activated" notifications.

those can be disabled with

```
gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"
gsettings set org.gnome.nm-applet disable-connected-notifications "true"
```

## cursor

to set the cursor, open `nwg-look` and go to `Mouse cursor` and set the theme to `Posy's Cursor 125%`.
![image](https://raw.githubusercontent.com/liaminventions/dotfiles/main/images/posy.png)


## wf-recorder

be sure to select the correct audio source with `pavucontrol` when screen recording.

to do this, go to pavucontrol and to the "Recording" tab (while screen recording) and select the correct audio source.

for example:

![](https://raw.githubusercontent.com/liaminventions/dotfiles/main/images/pa.png)

also, you only have to do this once, the settings will save.

## missing drivers/firmware

on my hp-dy2024nr, the power button and lid does nothing, so, i made a fix.

to enable it, just uncomment the `source=~/.config/hypr/missingdriversfix.conf` line in `hyprland.conf`

## themes

i use the `adwaita-icon-them`, `gnome-themes-extra`, and `epapirus-icon-theme` packages, and they can be set in `nwg-look`:

![image](https://raw.githubusercontent.com/liaminventions/dotfiles/main/images/adwaita.png)
![image](https://raw.githubusercontent.com/liaminventions/dotfiles/main/images/epap.png)

