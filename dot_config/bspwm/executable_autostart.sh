#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Find out your monitor name with xrandr or arandr (save and you get this line)
# xrandr --output DP-0 --scale 0.8x0.8 &
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

$HOME/.config/polybar/launch.sh &

#change your keyboard if you need it
# setxkbmap -option grp:alt_shift_toggle us,ru
setxkbmap -option caps:escape
#Disable mouse acceleration
xinput --set-prop 'pointer:Logitech G Pro ' 'libinput Accel Profile Enabled' 0, 1
#Set mouse speed to .95%
xinput --set-prop 'pointer:Logitech G Pro ' 'Coordinate Transformation Matrix' 0.6, 0.000000, 0.000000, 0.000000, 0.6, 0.000000, 0.000000, 0.000000, 1.000000
#Some ways to set your wallpaper besides variety or nitrogen
# feh --bg-fill /usr/share/backgrounds/arcolinux/koi-fishes-1920x1080.png &

# dex $HOME/.config/autostart/arcolinux-welcome-app.desktop
dex /usr/share/applications/org.fcitx.Fcitx5.desktop
xsetroot -cursor_name left_ptr &
run sxhkd -c ~/.config/bspwm/sxhkd/sxhkdrc &

conky -c $HOME/.config/bspwm/system-overview &
run variety &
run nm-applet &
run pamac-tray &
run xfce4-power-manager &
numlockx on &
blueberry-tray &
picom --config $HOME/.config/bspwm/picom.conf --experimental-backends &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/xfce4/notifyd/xfce4-notifyd &
run volumeicon &
nvidia-settings --assign CurrentMetaMode="DPY-0: nvidia-auto-select +0+0 { ViewPortIn=3072x1728, ViewPortOut=3840x2160+0+0, ForceFullCompositionPipeline = On }, DPY-2: nvidia-auto-select @1920x1080 +3072+0 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0, ForceFullCompositionPipeline = On}" &
#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run discord &
#run spotify &
#run atom &
