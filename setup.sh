#!/bin/bash

set -ux

TARGET=${1:-$HOME}

mkdir -p "${TARGET}/.config/nvim/lua"

ln -s "${PWD}/init.lua" "${TARGET}/.config/nvim/"
ln -s "${PWD}/lua/"* "${TARGET}/.config/nvim/lua/"

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync' | :
