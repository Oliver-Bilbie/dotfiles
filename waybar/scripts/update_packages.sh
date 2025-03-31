#!/bin/sh

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
CYAN=$(tput setaf 6)
RESET=$(tput sgr0)

update_official() {
    echo "${GREEN}[✓] Updating official packages...${RESET}"
    sudo pacman -Syu
}

update_aur() {
    echo "${GREEN}[✓] Updating AUR packages...${RESET}"
    yay -Syu
}

update_flatpak() {
    echo "${GREEN}[✓] Update Flatpak packages...${RESET}"
    flatpak upgrade
}

sudo -v
echo "${CYAN}Which processes do you want to run? (Enter multiple choices separated by spaces)${RESET}"
echo " ${YELLOW}[A]${RESET} Official packages"
echo " ${YELLOW}[B]${RESET} AUR packages"
echo " ${YELLOW}[C]${RESET} Flatpak packages"
echo "Press Enter to run ALL processes."
echo ""

read -r -p "Your choice: " choices

# Default to all options if no input
[ -z "$choices" ] && choices="A B C"

echo "${CYAN}-------------------------${RESET}"

for choice in $choices; do
    case "$choice" in
        A|a) update_official ;;
        B|b) update_aur ;;
        C|c) update_flatpak ;;
        *) echo "${RED}[!] Invalid choice: $choice${RESET}" ;;
    esac
done

echo ""
echo "${CYAN}All selected processes finished.${RESET}"
echo "${CYAN}-------------------------${RESET}"
