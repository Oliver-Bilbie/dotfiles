dotfile_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: clean link

clean:
	@echo "[INFO] Removing existing configuration files..."
	@rm -rf ~/.config/nvim
	@rm ~/.tmux.conf

link:
	@echo "[INFO] Creating symlinks to this repository..."
	@ln -s $(dotfile_dir)/nvim ~/.config/nvim
	@ln -s $(dotfile_dir)/tmux/.tmux.conf ~/.tmux.conf
