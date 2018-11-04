#!/bin/bash

set -eux

TARGET=$HOME

mkdir -p "${TARGET}/.vim/syntax_checkers"
mkdir -p "${TARGET}/.vim/after/syntax"
mkdir -p "${TARGET}/.config/nvim"

ln -s "${PWD}/after/syntax/"* "${TARGET}/.vim/after/syntax/"
ln -s "${PWD}/sources/" "${TARGET}/.vim/sources"

ln -s "${TARGET}/.vimrc" "${TARGET}/.config/nvim/init.vim"
ln -s "${TARGET}/.vim/sources/vimrc" "${TARGET}/.vimrc"
ln -s "${TARGET}/.vim/after/" "${TARGET}/.config/nvim/"
ln -s "${TARGET}/.vim/syntax_checkers/" "${TARGET}/.config/nvim/"

# gonvim
mkdir -p "${TARGET}/.gonvim"
ln -s "${PWD}/gonvim/setting.toml" "${TARGET}/.gonvim/"
ln -s "${pwd}/gonvim/ginit.vim" "${TARGET}/.config/nvim/"

# dein
ln -s "${PWD}/dein" "${TARGET}/.config/nvim/"

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein-installer.sh
sh /tmp/dein-installer.sh ~/.cache/dein
nvim --headless +'call dein#install()' +UpdateRemotePlugins +q

