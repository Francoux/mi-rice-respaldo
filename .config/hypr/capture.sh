#!/bin/bash

# Directorio SOLO para video (porque el video no se puede copiar al clipboard igual)
VID_DIR="$HOME/Videos"
mkdir -p "$VID_DIR"

# ESTILO VISUAL (Tipo GNOME)
SLURP_ARGS="-d -b 000000aa -c ffffffff -w 2"

# 1. Lógica de "Toggle" para grabación
if pgrep -x "wf-recorder" > /dev/null; then
  pkill -INT -x wf-recorder
  notify-send -t 2000 "⏺️ Grabación Finalizada" "Video guardado en $VID_DIR"
  exit 0
fi

# 2. Función "Imán" de Ventanas
get_geometry() {
  hyprctl clients -j | jq -r '.[] | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp $SLURP_ARGS
}

# 3. Funciones Principales (AHORA SOLO COPIAN)

screenshot_area() {
  GEOM=$(get_geometry)
  if [ -z "$GEOM" ]; then exit; fi
  
  # Captura zona -> Copia al portapapeles -> Notifica
  grim -g "$GEOM" - | wl-copy
  notify-send -t 1000 "📋 Copiado" "Captura de zona lista para pegar"
}

screenshot_full() {
  sleep 0.2
  # Captura todo -> Copia al portapapeles -> Notifica
  grim - | wl-copy
  notify-send -t 1000 "📋 Copiado" "Pantalla completa lista para pegar"
}

record_area() {
  # EL VIDEO SÍ SE TIENE QUE GUARDAR (No cabe en el portapapeles)
  notify-send "🔴 Grabando Zona" "Ejecuta de nuevo para detener"
  GEOM=$(get_geometry)
  if [ -z "$GEOM" ]; then exit; fi
  
  wf-recorder -g "$GEOM" --audio=$(pactl get-default-sink).monitor -f "$VID_DIR/Video_$(date +%Y-%m-%d_%H-%M-%S).mp4" &
}

# 4. Menú Wofi
OPCIONES="  Zona / Ventana (Copiar)\n  Pantalla Completa (Copiar)\n📹  Grabar Zona (Guardar MP4)"

CHOICE=$(echo -e "$OPCIONES" | wofi --dmenu --prompt "Captura (RAM)" --width 350 --height 220)

case "$CHOICE" in
  "  Zona / Ventana (Copiar)") screenshot_area ;;
  "  Pantalla Completa (Copiar)") screenshot_full ;;
  "📹  Grabar Zona (Guardar MP4)") record_area ;;
esac
