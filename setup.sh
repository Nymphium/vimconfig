#!/usr/bin/bash

set -eux

TARGET=$HOME

mkdir -p "${TARGET}"/.vim/{after/syntax,bundle,syntax_checkers}

ln -s "${PWD}"/syntax/* "${TARGET}/.vim/after/syntax/"
ln -s "${PWD}/sources/" "${TARGET}/.vim/"
ln -s "${TARGET}/.vim/sources/vimrc" "${TARGET}/.vimrc"

# Neovim
mkdir -p "${TARGET}/.config/nvim/"

ln -s "${PWD}/sources/vimrc" "${TARGET}/.config/nvim/init.vim"
ln -s "${TARGET}/.vim/syntax_checkers/" "${TARGET}/.config/nvim/"

# neobundle
if [[ ! -a "${TARGET}/.vim/bundle/neobundle.vim" ]]; then
	git clone https://github.com/Shougo/neobundle.vim "${TARGET}/.vim/bundle/neobundle.vim"
fi

case "${EDITOR:-vim}" in
	vim)
		vim -c :NeoBundleUpdate -c :q;;
	nvim)
		nvim --headless -c :NeoBundleUpdate -c :UpdateRemotePlugins -c :q
esac

