dotfile_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: link

clean:
	@echo "[INFO] Removing existing configuration files..."
	@rm -rf ~/.config/nvim
	@rm -rf ~/.config/ghostty
	@rm -rf ~/.config/alacritty
	@rm -rf ~/.config/lazygit/config.yml
	@rm ~/.tmux.conf
	@rm -rf ~/.config/uwsm
	@rm -rf ~/.config/hypr
	@rm -rf ~/.config/wofi
	@rm -rf ~/.config/waybar
	@rm -rf ~/.config/mako
	@rm -rf ~/.config/gamemode

link:
	@echo "[INFO] Creating symlinks to this repository..."
	@ln -s $(dotfile_dir)/nvim ~/.config/nvim
	@ln -s $(dotfile_dir)/ghostty ~/.config/ghostty
	@ln -s $(dotfile_dir)/alacritty ~/.config/alacritty
	@ln -s $(dotfile_dir)/lazygit/config.yml ~/.config/lazygit/config.yml
	@ln -s $(dotfile_dir)/tmux/tmux.conf ~/.tmux.conf
	@ln -s $(dotfile_dir)/uwsm ~/.config/uwsm
	@ln -s $(dotfile_dir)/hypr ~/.config/hypr
	@ln -s $(dotfile_dir)/wofi ~/.config/wofi
	@ln -s $(dotfile_dir)/waybar ~/.config/waybar
	@ln -s $(dotfile_dir)/mako ~/.config/mako
	@ln -s $(dotfile_dir)/gamemode ~/.config/gamemode
	@echo "[INFO] Ready to go! 🚀"
