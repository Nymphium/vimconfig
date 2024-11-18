#!/bin/bash

set -ux

TARGET=${1:-$HOME}

mkdir -p "${TARGET}/.config/nvim/"{lua,nlsp-settings}

ln -s "${PWD}/init.lua" "${TARGET}/.config/nvim/"
ln -s "${PWD}/lua/"* "${TARGET}/.config/nvim/lua/"
ln -s "${PWD}/nlsp-settings/"* "${TARGET}/.config/nvim/nlsp-settings"

nvim -u packer_init.lua --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim -u lua/plugins.lua --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
