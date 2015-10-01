#!/usr/bin/env bash
pushd ~/.vim/colors
curl -L -O http://www.vim.org/scripts/download_script.php?src_id=9818
curl -L -O http://blog.toddwerth.com/entry_files/8/ir_black.vim
popd

mkdir -p ~/.vim/after/syntax/cpp
pushd ~/.vim/after/syntax/cpp
curl -L -o stl.vim http://www.vim.org/scripts/download_script.php?src_id=22034
