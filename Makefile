SHELL := /usr/bin/env bash

FONT_URL := https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/BigBlueTerminal.tar.xz
AUR_HELPER := $(shell (command -v paru || command -v yay) 2>/dev/null)

PACKAGES_NEEDED = git curl
PACKAGES_INSTALL = \
	hyprland-git hypridle-git hyprqt6engine-git hyprwayland-scanner-git hyprland-qt-support \
	xdg-desktop-portal-hyprland xdg-desktop-portal-cosmic xdg-desktop-portal-gtk pantheon-polkit-agent \
	quickshell foot flatpak \
	mpd mpd-mpris mpc upower wireplumber trash-clij\
	elephant elephant-bluetooth elephant-calc elephant-clipboard elephant-desktopapplications elephant-files elephant-providerlist elephant-symbols elephant-websearch walker \
	jq lf bash blesh-git eza fzf rmpc neovim wiremix \
    noto-fonts noto-fonts-cjk ttf-noto-emoji-monochrome

SERVICES = \
	elephant.service walker.service \
	phantheon-polkit.service xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
	foot-server.service hypridle.service quickshell.service \
	mpd.service mpd-mpris.service

CONFIG_DIRS := $(shell ls -1 .config)

install: check_inet install_packages copy_configs install_plugins install_font enable_services
	@echo "[INFO] Installation finished!"

check_inet:
	@if ! ping -q -c 1 github.com &>/dev/null; then \
		echo "[ERROR] No internet connection."; \
		exit 1; \
	fi

install_packages:
	@if command -v pacman &>/dev/null && [ -n "$(AUR_HELPER)" ]; then \
		echo "[INFO] Using AUR helper: $(AUR_HELPER)"; \
		$(AUR_HELPER) -S $(PACKAGES_INSTALL); \
	else \
		echo "[WARN] No AUR helper found — skipping installation of packages."; \
	fi

copy_configs:
	@echo "[INFO] Copying configs…"
	@for dir in $(CONFIG_DIRS); do \
		dest="$$HOME/.config/$$dir"; \
		if [[ -e $$dest ]]; then \
			if command -v trash-put &>/dev/null; then \
				trash-put $$dest; \
			else \
				mv $$dest $$dest.bak; \
			fi; \
		fi; \
		cp -rf ".config/$$dir/." "$$dest/"; \
		echo "  -> Copied .config/$$dir"; \
	done
	@mkdir -p ~/.local/bin/
	@cp -rf .local/bin/* ~/.local/bin/ && echo "  -> Copied .local/bin"
	@if command -v trash-put &>/dev/null; then \
		trash-put ~/.bashrc; \
	else \
		mv ~/.bashrc ~/.bashrc.bak; \
	fi
	@cp .bashrc ~/.bashrc  && echo "  -> Copied .bashrc"

install_plugins: 
	@echo "[INFO] Installing Plugins... "
	@if [[ "$$XDG_SESSION_DESKTOP" = "Hyprland" ]]; then \
		hyprpm add "https://codeberg.org/zacoons/imgborders" && \
		hyprpm enable imgborders; \
		echo "[OK] Installed plugin imgborders"; \
	else 
		echo "[WARN] You are not in a Hyprland session."; \
		echo "Run 'make install_plugins' inside Hyprland to install the required plugins."; \
	fi

install_font:
	@echo "[INFO] Downloading Nerd Font"
	@tmp=$$(mktemp -d); \
	    curl -s -L -o $$tmp/font.tar.xz $(FONT_URL); \
	    tar xJf $$tmp/font.tar.xz -C $$tmp; \
	    mkdir -p ~/.local/share/fonts; \
	    mv $$tmp/*.ttf ~/.local/share/fonts/; \
	    rm -rf $$tmp
	@echo "[OK] Nerd Font installed"

enable_services: 
	@echo "[INFO] Adding systemd user services"
	@for service in $(SERVICES); do \
		systemctl --user add-wants graphical-session.target "$$service" &>/dev/null; \
		echo "[OK] Added $$service to graphical-session.target"; \
	done
