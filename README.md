# 🛡️ Bóveda de Respaldo: Arch Linux + Hyprland
Este repositorio contiene mi configuración personal (rice) de Arch Linux "bien duro", incluyendo Hyprland, Waybar, Wofi, Kitty, Zsh y mis listas de paquetes.

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/852df2cd-6880-4156-9f49-ecbdcc2966f6" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6d9e7b12-bdd1-4697-96ec-70ae799e5ee2" />


## 🚨 Manual del Fin del Mundo (Restauración desde cero)

Si el sistema explotó y acabas de instalar un Arch Linux base, sigue estos pasos para clonar el entorno gráfico exacto:

### 1. Preparativos
Asegúrate de tener instalados `git` y tu helper de AUR (`yay`):
```bash
sudo pacman -S git base-devel
# Instalar yay si no lo tienes...
```

### 2. Descargar la Bóveda
```bash
git clone https://github.com/Francoux/mi-rice-respaldo.git ~/mi-rice-respaldo
cd ~/mi-rice-respaldo
```

### 3. Inyectar el ADN (Instalar todos los programas)
Instala los paquetes oficiales y los de la comunidad (AUR) directamente de las listas guardadas:
```bash
sudo pacman -S --needed - < paquetes/oficiales.txt
yay -S --needed - < paquetes/aur.txt
```

### 4. Restaurar las Configuraciones
Mueve todas las carpetas a su lugar para revivir el entorno gráfico y la consola:
```bash
cp -r .config/* ~/.config/
cp .zshrc .bashrc ~/
```

### 5. Reiniciar
```bash
sudo reboot
```
¡Y listo! El sistema regresará a la normalidad.
