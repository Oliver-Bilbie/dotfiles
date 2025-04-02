.PHONY: systemd
dotfile_dir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

all: clean systemd link

clean:
	@echo "[INFO] Removing existing configuration files..."
	@rm -rf ~/.config/nvim
	@rm -rf ~/.config/ghostty
	@rm -rf ~/.config/alacritty
	@rm -rf ~/.config/lazygit/config.yml
	@rm ~/.tmux.conf
	@rm -rf ~/.config/hypr
	@rm -rf ~/.config/wofi
	@rm -rf ~/.config/waybar

link:
	@echo "[INFO] Creating symlinks to this repository..."
	@ln -s $(dotfile_dir)/nvim ~/.config/nvim
	@ln -s $(dotfile_dir)/ghostty ~/.config/ghostty
	@ln -s $(dotfile_dir)/alacritty ~/.config/alacritty
	@ln -s $(dotfile_dir)/lazygit/config.yml ~/.config/lazygit/config.yml
	@ln -s $(dotfile_dir)/tmux/tmux.conf ~/.tmux.conf
	@ln -s $(dotfile_dir)/hypr ~/.config/hypr
	@ln -s $(dotfile_dir)/wofi ~/.config/wofi
	@ln -s $(dotfile_dir)/waybar ~/.config/waybar
	@echo "[INFO] Ready to go! 🚀"

systemd:
	@echo "[INFO] Creating systemd services..."
	@for file in $(shell find $(dotfile_dir)/systemd -type f); do \
		sudo ln -sf $$file /etc/systemd/system/$$(basename $$file); \
	done
	@echo "[INFO] Reloading systemd daemon..."
	@sudo systemctl daemon-reload
	@echo "[INFO] Enabling systemd services..."
	@sudo systemctl enable --now hyprsunset.timer
