#!/usr/bin/env bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

# Use package feature to install coc.nvim

# for vim8
mkdir -p ~/.vim/pack/coc/start
cd ~/.vim/pack/coc/start
curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{"coc-clangd": ">=0.4.14",
    "coc-python": ">=1.2.12"}}'> package.json
fi
# Change extension names to the extensions you need
npm install coc-clangd coc-python --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
