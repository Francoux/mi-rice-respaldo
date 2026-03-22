#!/bin/bash

# --- 1. AUTO-DESCONEXIÓN (Vital para Waybar) ---
if [ "$1" != "--detached" ]; then
    nohup "$0" --detached "$@" > /dev/null 2>&1 &
    exit 0
fi
shift 1

# --- 2. PEQUEÑA PAUSA (LA SOLUCIÓN AL MOUSE) ---
# Damos 0.1s para que Waybar termine de registrar el clic antes de abrir nada.
sleep 0.1

TYPE=$1
CMD=$2
CLASS="dropdown_$TYPE"

# --- 3. LOGICA TOGGLE ---
if hyprctl clients | grep -q "class: $CLASS"; then
    hyprctl dispatch closewindow "class:$CLASS"
    exit
fi

# --- 4. REGLAS ---
case $TYPE in
    "wifi")
        RULES="[float;size 600 500;move 1300 55]"
        ;;
    "bt")
        RULES="[float;size 400 400;move 1500 55]"
        ;;
    "audio")
        RULES="[float;size 500 350;move 1400 55]"
        ;;
esac

# --- 5. EJECUTAR ---
hyprctl dispatch exec "$RULES kitty --class $CLASS --title $CLASS -e $CMD"
