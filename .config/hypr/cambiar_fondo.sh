#!/bin/bash
DIR="/home/franco/Pictures/Background"

# Esperar a que Hyprland y swww-daemon estén listos al arrancar
sleep 3

handle() {
  case $1 in
    "workspace>>"*)
      ws=${1#*>>}
      # Busca imagen jpg o png
      IMG=$(find "$DIR" -name "$ws.*" | head -n 1)

      if [ -f "$IMG" ]; then
        # VELOCIDAD 0.4s
        swww img "$IMG" --transition-type grow --transition-duration 0.4 --transition-fps 60
        
        # Colores (Asíncrono para no trabar)
# (wal -i "$IMG" -n -q && pkill -USR2 waybar) &
      fi
      ;;
  esac
}

# Loop simple (La redirección ya está en el hyprland.conf)
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do 
    handle "$line" 
done
