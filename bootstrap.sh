OS="arch" # "arch" | "macos"
SHELL="bash" # "bash" | "zsh"

pip install -U pynvim --break-system-packages
pip install 'python-lsp-server[all]' pylsp-mypy python-lsp-isort python-lsp-black --break-system-packages

wget https://nodejs.org/dist/v14.15.4/node-v14.15.4-linux-x64.tar.xz
mkdir -p $HOME/tools
tar xvf node-v14.15.4-linux-x64.tar.xz --directory=$HOME/tools

echo 'export PATH="$HOME/tools/node-v14.15.4-linux-x64/bin:$PATH"' >> ~/.${SHELL}rc
source ~/.${SHELL}rc

npm install -g vim-language-server

if [ $OS == "arch" ]; then
	sudo pacman -S neovim ripgrep lazygit lua-language-server
	# install ctags from source
	cd /tmp
	git clone https://github.com/universal-ctags/ctags.git
	cd ctags
	./autogen.sh
	./configure
	make
	sudo make install
else
	brew install neovim ripgrep lazygit ctags lua-language-server hashicorp/tap/terraform-ls
fi

pip install pylint flake8 vim-vint --break-system-packages
npm i -g bash-language-server

git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim

rm -rf ~/.config/nvim/
mkdir ~/.config/nvim
cd ~/.config/nvim
git clone --depth=1 git@github.com:Oliver-Bilbie/nvim-config.git .
