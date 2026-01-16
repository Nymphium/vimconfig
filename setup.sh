#!/bin/bash

set -ux

TARGET=${1:-$HOME}

mkdir -p "${TARGET}/.config/nvim/"{lua,after/lsp}

ln -sf "${PWD}/init.lua" "${TARGET}/.config/nvim/"
ln -sf "${PWD}/lua/"* "${TARGET}/.config/nvim/lua/"
ln -sf "${PWD}/after/lsp/"* "${TARGET}/.config/nvim/after/lsp"

nvim --headless "+Lazy! sync" +qa
nvim --headless '+TSUpdate' +qa
