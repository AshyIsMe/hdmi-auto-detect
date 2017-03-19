#!/bin/bash
set -x
export DISPLAY=:0

#hdmi_status="$(cat /sys/class/drm/card0-HDMI-A-1/status)"
hdmi_status="$(cat /sys/class/drm/card*-HDMI-A-1/status | head -n1)"

#change-display() {
  #local user="$(w -h | grep tty | head -n1 | awk '{print $1}')"

  #if [[ $hdmi_status == "disconnected" ]]; then
      #[[ $(pgrep X) > 0 ]] && su $user -c "xrandr --output HDMI-1 --off"
  #else
      ##[[ $(pgrep X) > 0 ]] && su $user -c "xrandr --output eDP-1 --auto --output HDMI-1 --auto --right-of eDP-1"
      #[[ $(pgrep X) > 0 ]] && su $user -c "xrandr --output eDP-1 --auto --output HDMI-1 --auto --above eDP-1"
  #fi
#}

change-display() {
  local user="$(w -h | grep tty | head -n1 | awk '{print $1}')"
  export XAUTHORITY="/home/$user/.Xauthority"

  if [[ $hdmi_status == "disconnected" ]]; then
      [[ $(pgrep X) -gt 0 ]] && xrandr --output HDMI-1 --off
  else
      [[ $(pgrep X) -gt 0 ]] && xrandr --output eDP-1 --auto --output HDMI-1 --auto --above eDP-1
  fi
}

change-audio() {
  ln -sf "/etc/alsa/asound.hdmi-$hdmi_status" /etc/asound.conf
  /usr/sbin/alsactl restore
}

change-display
#change-audio

exit 0
