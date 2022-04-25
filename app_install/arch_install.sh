#!/usr/bin/env bash
set -euo pipefail

# Run this in a subshell so we don't disturb main script working directory
ensure_yay() (
  if ! command -v yay &>/dev/null; then
    echo "Installing yay"
    pacman -S --needed git base-devel
    mkdir -p /tmp/yay
    cd /tmp/yay || exit 1
    git clone https://aur.archlinux.org/yay.git
    cd yay || exit 1
    makepkg -si
  fi
)

base() {
  local depends=(
    'bat'
    'bind-tools'
    'exa-git'
    'fd'
    'fzf'
    'git'
    'git-delta'
    'htop'
    'jq'
    'man-db'
    'nmap'
    'openssh'
    'pacman-contrib'
    'ripgrep'
    'starship'
    'tmux'
    'unzip'
    'vim'
    'zip'
  )

  install depends
}

db() {
  local depends=(
    'pspg'
    'postgresql'
    'sqlite3'
  )

  install depends
}

docker() {
  local depends=(
    'dive'
    'docker'
    'hadolint-bin'
  )

  install depends

  systemctl enable --now docker
  usermod -aG docker bob
}

editor() {
  local depends=(
    'prettier'
    'shellcheck-bin'
    'shfmt'
    'vim'
  )

  install depends
}

embedded() {
  local depends=(
    'picocom'
    'rustup'
  )

  install depends
}

fonts() {
  local depends=(
    'adobe-source-code-pro-fonts'
    'nerd-fonts-complete-starship'
  )

  install depends
}

gui() {
  local depends=(
    '1password'
    'alacritty'
    'etcher-bin'
    'feh'
    'firefox'
    'google-chrome'
  )

  install depends
}

i3() {
  local depends=(
    'arc-gtk-theme'
    'autorandr'
    'dunst'
    'i3-gaps'
    'i3lock'
    'lxrandr-gtk3'
    'papirus-icon-theme'
    'polybar'
    'redshift'
    'rofi'
    'rofi-dmenu'
    'xautolock'
    'xorg-server'
    'xorg-xhost'
    'xorg-xinit'
    'xorg-xprop'
    'xorg-xrandr'
    'xorg-xsetroot'
  )

  install depends
}

k8s() {
  local depends=(
    'kubectl'
    'kubectx'
  )

  install depends
}

printer() {
  local depends=(
    'brother-hll2360d'
    'cups'
    'cups-pdf'
  )

  install depends
}

sound() {
  local depends=(
    'bluez'
    'bluez-utils'
    'pipewire'
    'wireplumber'
  )

  install depends

  systemctl enable --now bluetooth.service
}

sway() {
  local depends=(
    'sway'
    'swaylock'
    'swayidle'
    'waybar'
    'dmenu'
    'light'
    'grim'
    'slurp'
    'pavucontrol'
  )

  install depends
}

install() {
  local -n packages=$1
  for PKG in "${packages[@]}"; do
    echo "Installing ${PKG}"
    # yay "${PKG}"
  done
}

ensure_yay
programming
