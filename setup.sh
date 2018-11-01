#!/bin/bash

set -eux

TARGET=$HOME

mkdir -p "${TARGET}"/.vim/{after/syntax,bundle,syntax_checkers}

ln -s "${PWD}"/syntax/* "${TARGET}/.vim/after/syntax/"
ln -s "${PWD}/sources/" "${TARGET}/.vim/sources"
ln -s "${TARGET}/.vim/sources/vimrc" "${TARGET}/.vimrc"

# Neovim
mkdir -p "${TARGET}/.config/nvim"

ln -s "${PWD}/sources/vimrc" "${TARGET}/.config/nvim/init.vim"
ln -s "${TARGET}/.vim/syntax_checkers/" "${TARGET}/.config/nvim/syntax_checkers"
ln -s "${PWD}/dein" "${TARGET}/.config/nvim/"

# neobundle
if [[ ! -a "${TARGET}/.vim/bundle/neobundle.vim" ]]; then
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein-installer.sh
	sh /tmp/dein-installer.sh ~/.cache/dein
fi

case "${EDITOR:-nvim}" in
	nvim)
		nvim +'call dein#install()' +UpdateRemotePlugins +q
esac

