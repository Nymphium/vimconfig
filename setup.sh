#!/bin/bash

set -ux

TARGET=${1:-$HOME}

mkdir -p "${TARGET}/.config/nvim/lua"
mkdir -p "${TARGET}/.config/nvim/after/"{ftplugin,ftdetect}
mkdir -p "${TARGET}/.config/nvim/sources"


ln -s "${PWD}/after/ftplugin/"* "${TARGET}/.config/nvim/after/ftplugin/"
ln -s "${PWD}/after/ftdetect/"* "${TARGET}/.config/nvim/after/ftdetect/"
ln -s "${PWD}/lua/"* "${TARGET}/.config/nvim/lua/"

ln -s "${PWD}/sources/vimrc" "${TARGET}/.config/nvim/init.vim"
ln -s "${PWD}/sources/"* "${TARGET}/.config/nvim/sources/"

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' | :
