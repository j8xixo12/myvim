PREFIX ?= /usr/local

OS := $(shell uname -s)

Python3 ?= $(shell python3-config --configdir)

all: vim bear clangd Vim-Plug YCM

Vim-Plug: 
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

bear:
ifeq ($(OS), Linux)
	sudo apt-get -y install bear
endif
ifeq ($(OS), Darwin)
	brew install bear
endif

clangd:
ifeq ($(OS), Linux)
	sudo apt-get install -y clangd-10
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
	sudo apt install -y build-essential cmake python3-dev	
endif
	git clone https://github.com/ycm-core/YouCompleteMe.git ~/.vim/plugged/YouCompleteMe && \
	cd ~/.vim/plugged/YouCompleteMe && \
	git submodule update --init --recursive && \
	python3 install.py --clangd-completer

.PHONY: vim
/tmp/vim:
	$(eval src = /tmp/vim)
	git clone https://github.com/vim/vim.git $(src)
vim: $(PREFIX)/bin/vim
$(PREFIX)/bin/vim: /tmp/vim
		$(eval src = /tmp/vim)
		cd $(src) && \
		./configure --with-features=huge \
            --enable-multibyte \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(Python3) \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=$(PREFIX) && \
		make -j8 VIMRUNTIMEDIR=/usr/local/share/vim/vim82 && \
		sudo make install && \
		rm -rf $(src) && \
		echo 'alias vim='/usr/local/bin/vim'' >> ~/.zshrc
.PHONY: vimrc
vimrc:
	cp vimrc ~/.vimrc
	cp -R vimsetting ~/.vim/
	vim +PlugInstall +qall
