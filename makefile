SHELL := bash

PREFIX ?= /usr/local

OS := $(SHELL uname -s)

all: vim bear clangd Vim-Plug

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

vim: $(PREFIX)/bin/vim
$(PREFIX)/bin/vim:
		$(eval src = /tmp/vim)
		git clone https://github.com/vim/vim.git $(src)
		cd $(src) && \
		git checkout $(VIM_VERSION) && \
		./configure --with-features=huge --enable-multibyte \
			--enable-rubyinterp=yes --enable-pythoninterp=yes \
			--enable-python3interp=yes --enable-perlinterp=yes \
			--enable-luainterp=yes --prefix=$(PREFIX) && \
		make -j8 && \
		make install \
		rm -rf $(src) && \
		echo 'alias vim='/usr/local/bin/vim'' >> ~/.zshrc
.PHONY: vimrc
vimrc:
	cp vimrc ~/.vimrc
	cp -R vimsetting ~/.vim/

