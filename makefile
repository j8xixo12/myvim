SHELL := bash

PREFIX ?= /usr/local

OS := $(SHELL uname -s)

all: vim bear clangd Vim-Plug YCM

Vim-Plug: 
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

bear:
	ifeq ($(OS), Linux)
		sudo apt-get install bear
	endif
	ifeq ($(OS), Darwin)
		brew install bear
	endif

clangd:
	ifeq ($(OS), Linux)
		sudo apt-get install -y clangd
	endif
	ifeq ($(OS), Darwin)
		brew install llvm \
		echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc
	endif

YCM:
	ifeq ($(OS), Darwin)
		brew install cmake python@3.6.0 mono go nodejs
	endif
	ifeq ($(OS), Linux)
		sudo apt-get install cmake python=3.6.0 mono go nodejs
	endif
	git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/plugged/YouCompleteMe \
	cd ~/.vim/plugged/YouCompleteMe \
	python3 install.py --clangd-completer

.PHONY: vim
vim: $(PREFIX)/bin/vim
$(PREFIX)/bin/vim:
		$(eval src = /tmp/vim)
		git clone https://github.com/vim/vim.git $(src)
		cd $(src) && \
		./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=$(PREFIX) \
		make -j8 VIMRUNTIMEDIR=/usr/local/share/vim/vim82 && \
		make install \
		rm -rf $(src) && \
		echo 'alias vim='/usr/local/bin/vim'' >> ~/.zshrc

.PHONY: vimrc
vimrc:
	cp vimrc ~/.vimrc
	cp -R vimsetting ~/.vim/

