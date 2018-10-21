#!/bin/bash

set -eux

TARGET=$HOME

mkdir -p "${TARGET}"/.vim/{after/syntax,bundle,syntax_checkers}

ln -s "${PWD}"/syntax/* "${TARGET}/.vim/after/syntax/"
ln -s "${PWD}/sources/" "${TARGET}/.vim/sources"
ln -s "${TARGET}/.vim/sources/vimrc" "${TARGET}/.vimrc"

# Neovim
mkdir -p "${TARGET}/.config/nvim/"

ln -s "${PWD}/sources/vimrc" "${TARGET}/.config/nvim/init.vim"
ln -s "${TARGET}/.vim/syntax_checkers/" "${TARGET}/.config/nvim/syntax_checkers"

# neobundle
if [[ ! -a "${TARGET}/.vim/bundle/neobundle.vim" ]]; then
	curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
fi

case "${EDITOR:-vim}" in
	vim)
		vim -c :NeoBundleUpdate -c :q;;
	nvim)
		nvim +NeoBundleUpdate +UpdateRemotePlugins +q
esac

