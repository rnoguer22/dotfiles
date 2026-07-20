#!/bin/bash

# Directorio donde están tus dotfiles
DOTFILES_DIR="$HOME/dotfiles"

echo "Iniciando instalación de dotfiles..."

# 1. Actualizar sistema e instalar paquetes base desde repositorios oficiales
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm neovim kitty zsh firefox chromium python python-pip git wget curl hyprland hyprlock hypridle hyprshot hyprsunset wofi hyprpaper btop ranger waybar otf-font-awesome bottom bluetui ttf-ubuntu-font-family

# 2. Instalar yay si no existe
if ! command -v yay &>/dev/null; then
  echo "Instalando yay..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
fi

# 3. Instalar paquetes de AUR
yay -S --noconfirm wlogout google-chrome github-cli

# 4. Crear directorios de configuración si no existen
mkdir -p ~/.config
mkdir -p ~/Pictures

# 5. Crear enlaces simbólicos (ln -sf)
echo "Creando enlaces simbólicos..."

ln -sfT $DOTFILES_DIR/nvim ~/.config/nvim
ln -sfT $DOTFILES_DIR/kitty ~/.config/kitty
ln -sfT $DOTFILES_DIR/wofi ~/.config/wofi
ln -sfT $DOTFILES_DIR/hypr ~/.config/hypr
ln -sfT $DOTFILES_DIR/waybar ~/.config/waybar
ln -sfT $DOTFILES_DIR/btop ~/.config/btop
ln -sfT $DOTFILES_DIR/ranger ~/.config/ranger
ln -sf $DOTFILES_DIR/.zshrc ~/.zshrc
ln -sfT $DOTFILES_DIR/gtk-3.0 ~/.config/gtk-3.0
ln -sfT $DOTFILES_DIR/gtk-4.0 ~/.config/gtk-4.0
ln -sfT $DOTFILES_DIR/wallpapers ~/Pictures/wallpapers
ln -sfT $DOTFILES_DIR ~/.config

# 6. Configurar Zsh por defecto
if [[ "$SHELL" != *"zsh"* ]]; then
  chsh -s $(which zsh)
fi

echo "¡Configuración aplicada con éxito!"
