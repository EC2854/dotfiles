#!/usr/bin/env bash

FONT="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz"

not_arch_btw=false

packages_needed=(
    "git" "curl" # Bloated script XD
)
packages_to_install=(
    "niri" "swww" "mako" "pantheon-polkit-agent" "eww" "fuzzel" "xwayland-satellite" "hyprlock" "jq" "xdg-desktop-portal-gnome" "matugen" # important stuff
    "zsh" "eza" "fzf" "lf" "foot" "neovim" "fastfetch" "starship" "tmux" "mpd" "mpd-mpris" "rmpc" "zoxide" # terminal stuff
    "noto-fonts" "noto-fonts-cjk" "ttf-noto-emoji-monochrome" # non nerd fonts
    "acpi" "inotify-tools" # optional - for laptop eww
) 

# Print Functions
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

RESET='\033[0m'

print() {
    local type="$1"
    if [[ -z "$3" ]]; then 
        local message="$2"
        case "${type,,}" in
            "e"|"error")    local type="error"; local color="$RED" ;;
            "w"|"warning")  local type="warning"; local color="$YELLOW" ;;
            "i"|"info")     local type="info"; local color="$CYAN" ;;
            "s"|"success")  local type="success"; local color="$GREEN" ;;
            "script error") local color="$MAGENTA" ;;
            *) print "script error" "$type: type not found. pls provide color as a second argument. "; return 1;;
        esac
    else
        local color="$2"
        local message="$3"
    fi
    printf "%s[%s]%s %s\n" "$color" "${type^^}" "$RESET" "$message"
}

print w "this script is outdated it and won't work properly"

check_needed() {
    local installed
    installed=$(pacman -Qq)
    for package in "${packages_needed[@]}"; do
        grep -q "$package" <<< "$installed" || {
            print info "Installing dependencies for install script..."
            sudo pacman -S --noconfirm --needed "${packages_needed[@]}" 
            return
        }
    done

}
check_aur() {
    if command -v paru &>/dev/null; then
        aur_helper=paru
        print info "Using paru as the AUR helper."
    elif command -v yay &>/dev/null; then
        aur_helper=yay
        print info "Using yay as the AUR helper."
    else
        print warning "No AUR helper found. The script will continue, but it won't install packages."
    fi
}
clone_repository() {
    local repository_url="$1"
    local destination="$2"

    print info "Cloning $repository_url"
    git clone --quiet "$repository_url" "$destination" && print success "Cloned $destination successfully" || print error "Error cloning $repository_url to $destination"
    ls "$destination"/.git &>/dev/null && rm -rf "$destination"/.git
}
copy() {
    local source=$1 
    local destination="$2"

    print info "Copying files from $source to $destination"
    if ls "$destination" &> /dev/null; then
        mv "$destination" "$destination.bak"
        print info "Moved existing $destination to $destination.bak"
    fi
    mkdir -p "$destination"
    cp -rf "$source" "$destination" && print success "Files copied successfully to $destination" || print error "Error while copying to $destination"
}
install_modernz() {
    local mpv_dir
    mpv_dir=$(mktemp -d) &&

    print info "Installing mpv theme"
    clone_repository https://github.com/Samillion/ModernZ "$mpv_dir" 

    mkdir -p ~/.config/mpv/scripts
    mkdir -p ~/.config/mpv/fonts

    mv "$mpv_dir/modernz.lua" ~/.config/mpv/scripts
    mv "$mpv_dir/fluent-system-icons.ttf" ~/.config/mpv/fonts
    rm -rf "$mpv_dir"

    print success "Successfully installed mpv theme"
}
install_font() {
    local fonts_dir="$HOME/.local/share/fonts"
    local font_dir
    font_dir=$(mktemp -d)

    print info "Downloading nerd font"
    curl -s -o "$font_dir"/Meslo.tar.xz -L "$FONT" 
    tar xJf "$font_dir/Meslo.tar.xz" -C "$font_dir"

    mkdir -p "$fonts_dir"
    mv "$font_dir"/MesloLGLNerdFont* "$fonts_dir/"
    rm -rf "$font_dir"

    print success "Successfully downloaded nerd font"
}
ask_for_confirmation() {
    read -p "Do you want to continue? (y/n): " choice
    case "$choice" in 
        y|Y ) return 0 ;;
        n|N ) exit 0 ;;
        * ) 
            echo "Invalid choice. Please enter 'y' or 'n'."
            ask_for_confirmation 
        ;;
    esac
}
# Check Distro
command -v pacman &>/dev/null || { 
    print warning "This script is intended for Arch Linux. You can still run this script, but it won't install any packages." 
    not_arch_btw=true
}


# Check for internet connection
ping -q -c 1 github.com &>/dev/null || {
    print error "No internet connection. Exiting..." 
    exit 1 
}
# Check Folder
cd "$(dirname "$(realpath "$0")")" || { 
    print error "Please open folder with this script before running it" 
    exit 1 
}

if [[ $not_arch_btw = false ]]; then
    check_needed
    check_aur
fi

print warning "Check monitor config in ./config/kanshi/config before running the script."
ask_for_confirmation

[ -z "$aur_helper" ] && {
    print info "Starting package installation..."
    $aur_helper -S --noconfirm "${packages_to_install[@]}"
}

# copy configs
for file in .config/*; do
   copy "$file" ~/"$file"
done

copy .local/share/matugen ~/.local/share/matugen &
copy .local/share/scripts ~/.local/share/scripts &
copy .zshrc ~/.zshrc &

install_modernz &
install_font &

clone_repository https://github.com/EC2854/wallpapers ~/Pictures/Wallpapers &

print info "Enabling systemd services"


wait
print info "That's it!"
print info "Reboot ur system :3"
