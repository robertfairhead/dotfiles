#!/usr/bin/env bash
set -euo pipefail

# Run this in a subshell so we don't disturb main script working directory
ensure_yay() (
	if ! command -v yay &>/dev/null; then
		echo "Installing yay"
		sudo pacman -S --needed git base-devel
		mkdir -p /tmp/yay
		cd /tmp/yay || exit 1
		git clone https://aur.archlinux.org/yay.git
		cd yay || exit 1
		makepkg -si
	fi
)

install_base() {
	local depends=(
		'acpi'
		'bat'
		'bind-tools'
		'dracut-hook-uefi'
		'eza'
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
		'gvim'
		'zip'
	)

	install depends
	sudo cp "$HOME"/dotfiles/app_install/hooks/*.hook /usr/share/libalpm/hooks
}

install_db() {
	local depends=(
		'pspg'
		'postgresql'
		'sqlite3'
	)

	install depends
}

install_docker() {
	local depends=(
		'dive'
		'docker'
		'hadolint-bin'
	)

	install depends

	systemctl enable --now docker
	usermod -aG docker bob
}

install_editor() {
	local depends=(
		'prettier'
		'shellcheck-bin'
		'shfmt'
	)

	install depends
}

install_embedded() {
	local depends=(
		'picocom'
		'cmake'
	)

	local pico=(
		'arm-none-eabi-binutils'
		'arm-none-eabi-gcc'
		'arm-none-eabi-newlib'
		'arm-none-eabi-gdb'
	)

	install depends
	install pico
}

install_fonts() {
	local depends=(
		'adobe-source-code-pro-fonts'
		'nerd-fonts'
	)

	install depends
}

install_gui() {
	local depends=(
		'alacritty'
		'firefox'
		'google-chrome'
	)

	install depends
}

install_k8s() {
	local depends=(
		'kubectl'
		'kubectx'
	)

	install depends
}

install_printer() {
	local depends=(
		'brother-hll2360d'
		'cups'
		'cups-pdf'
	)

	install depends
}

install_sound() {
	local depends=(
		'bluez'
		'bluez-utils'
		'pipewire'
		'pipewire-alsa'
		'pipewire-pulse'
		'wireplumber'
	)

	install depends

	sudo systemctl enable --now bluetooth.service
}

install_sway() {
	local depends=(
		'sway'
		'swaybg'
		'swaylock'
		'swayidle'
		'waybar'
		'rofi-lbonn-wayland-git'
		'mako'
		'grim'
		'slurp'
		'wf-recorder'
		'wl-clipboard'
		'xdg-desktop-portal'
		'xdg-desktop-portal-wlr'
		'libnotify'
	)

	install depends
}

install() {
	local -n packages=$1
	echo Installing "${packages[@]}"
	yay -S --needed "${packages[@]}"
}

ensure_yay
install_base
install_editor
install_fonts
install_sound
install_sway
install_gui
