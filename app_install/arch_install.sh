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
		'vim'
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
		'nerd-fonts-complete-starship'
	)

	install depends
}

install_gui() {
	local depends=(
		'1password'
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

	systemctl enable --now bluetooth.service
}

install_sway() {
	local depends=(
		'sway'
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

install_hooks() {
	yay -S dracut-hook-uefi
	cp $HOME/dotfiles/app_install/hooks/*.hook /usr/share/libalpm/hooks
	find "$HOME/dotfiles/app_install/hooks" -type f ! -name "*.*" -exec cp {} /usr/share/libalpm/scripts \;
	chmod +x /usr/share/libalpm/scripts/*
}

install() {
	local -n packages=$1
	echo Installing "${packages[@]}"
	yay -S "${packages[@]}"
}

ensure_yay
install_embedded
