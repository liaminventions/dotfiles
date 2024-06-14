# dotfiles - sway-nosystemd branch
this branch is a version of the dotfiles that works on sway, also in artix-dinit
![](https://github.com/liaminventions/dotfiles/blob/sway-nosystemd/images/20240614-110215.png)

managed by [chezmoi](https://github.com/twpayne/chezmoi).

## keyboard layout:

WIP

## etc

this repo contains an `etc` directory.

to copy this to `/etc`, run (while in clone dir)
```
sudo cp -r etc/* /etc
```
this directory has `etc/default/grub`, `mkinitcpio.conf`

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

## waybar fonts

`ttf-font-awesome` and `ttf-roboto-mono` are needed for waybar to show correctly.

also, if you have a smaller screen resolution, consider un-commenting the `padding-right` css def in `~/.config/waybar/style.css`

overall, `~/.config/waybar/style.css` might need some sizes and padding adjusted for your screen

## wf-recorder

be sure to select the correct audio source with `pavucontrol` when screen recording.

to do this, go to pavucontrol and to the "Recording" tab (while screen recording) and select the correct audio source.

for example:

PICTURE COMING SOON

also, you only have to do this once, the settings will save.
