PREFIX ?= /usr/local

OS := $(shell uname -s)

Python3 ?= $(shell python3-config --configdir)

VIM_VERSION ?= v8.2.1738

all: bear clangd vim Vim-Plug color vimrc

Vim-Plug: 
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
color:
	git clone https://github.com/tomasr/molokai.git /tmp/molokai && \
	cd /tmp/molokai && \
	cp -R colors ~/.vim/ && \
	rm -rf /tmp/molokai

bear:
ifeq ($(OS), Linux)
	sudo apt-get -y install bear
else ifeq ($(OS), Darwin)
	brew install bear
endif

clangd_ver ?= clangd-10
clangd:
ifeq ($(OS), Linux)
	sudo apt-get install -y $(clangd_ver) && \
	sudo ln -sf /usr/bin/$(clangd_ver) /usr/bin/clangd
else ifeq ($(OS), Darwin)
	brew install llvm && \
	echo 'export PATH="/usr/local/opt/llvm/bin:$PATH"' >> ~/.zshrc
endif

nodejs:
ifeq ($(OS), Linux)
	sudo apt-get install -y nodejs
else ifeq ($(OS), Darwin)
	brew install node
endif

.PHONY: vim
/tmp/vim:
	$(eval src = /tmp/vim)
	git clone https://github.com/vim/vim.git $(src)
vim: $(PREFIX)/bin/vim
$(PREFIX)/bin/vim: /tmp/vim
		$(eval src = /tmp/vim)
		cd $(src) && \
		git checkout $(VIM_VERSION) && \
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
	ln -sf $(PWD)/.vimrc $(HOME)/.vimrc
	ln -sf $(PWD)/vimsetting $(HOME)/.vim/vimsetting
	vim +PlugInstall +qall
	
