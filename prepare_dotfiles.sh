#!/bin/bash

# Fichero para mover mi configuracion inicial a mi repo dotfiles

# Directorio de destino del repositorio
DEST_DIR="$HOME/dotfiles"

# Carpetas dentro de ~/.config/ que vamos a migrar
configs=("nvim" "kitty" "wofi" "hypr" "waybar" "btop" "ranger" "gtk-3.0" "gtk-4.0")

for item in "${configs[@]}"; do
  if [ -d "$HOME/.config/$item" ] || [ -f "$HOME/.config/$item" ]; then
    echo "Migrando $item..."
    # Movemos los ficheros a la carpeta ~/dotfiles/
    mv "$HOME/.config/$item" "$DEST_DIR/"
    # Y creamos un enlace simbólico de vuelta hacia .config
    ln -sf "$DEST_DIR/$item" "$HOME/.config/$item"
  fi
done

# Migramos .zshrc aparte, ya que no esta dentro de ~/.config/
if [ -f "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$DEST_DIR/"
  ln -sf "$DEST_DIR/.zshrc" "$HOME/.zshrc"
fi

# Y lo mismo con los wallpapers
if [ -d "$HOME/Pictures/wallpapers" ]; then
  echo "Migrando wallpapers..."
  mv "$HOME/Pictures/wallpapers" "$DEST_DIR/wallpapers"
  ln -sf "$DEST_DIR/wallpapers" "$HOME/Pictures/wallpapers"
fi

echo "Migración completada. Configuraciones guardadas en $DEST_DIR y enlazadas en $HOME/.config/."
