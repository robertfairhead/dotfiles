#! /usr/bin/env bash

set -euo pipefail

check_yay() {
    if ! command -v yay >/dev/null; then
        echo "Installing yay"

        local tmp=$(mktemp -d)
        trap "rm -rf $tmp" EXIT

        pushd ${tmp} >/dev/null

        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si

        popd >/dev/null
    fi
}

create_pkg() {
    echo "Building package locally"

    local tmp=$(mktemp -d)
    trap "rm -rf $tmp" EXIT

    pushd ${tmp} >/dev/null

    cp $HOME/dotfiles/app_install/PKGBUILD .
    makepkg -s

    cp *.pkg.tar.xz $HOME/dotfiles/app_install

    popd >/dev/null
}

make_local_repo() {

    check_yay

    local package=$(compgen -G "*.pkg.tar.xz")

    if [[ -z "${package}" ]]; then
        create_pkg
        package=$(compgen -G "*.pkg.tar.xz")
    fi

    local repo_dir="$HOME/.local/lib/bob-base"
    local repo_file="${repo_dir}/bob-base.db.tar.gz"
    mkdir -p "${repo_dir}"

    if [[ -f "${repo_file}" ]]; then
        rm -f "${repo_file}"
    fi

    repo-add "${repo_file}" "${package}"
    cp "${package}" "${repo_dir}"

    if grep -q "bob-base" /etc/pacman.conf; then
        return 0
    else
        sudo cp /etc/pacman.conf /etc/pacman.conf.old
        echo -e "[bob-base]\nSigLevel = Optional TrustAll\nServer = file:///${repo_dir}/" | sudo tee -a /etc/pacman.conf
    fi

    echo "Installing with yay -S bob-base"
    yay
    yay -S bob-base
}

make_local_repo

