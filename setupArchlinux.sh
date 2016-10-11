sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo cp arch/mirrorlist /etc/pacman.d/mirrorlist
sudo pacman -S --noconfirm archlinux-keyring
sudo pacman -Syu --noconfirm
sudo pacman-db-upgrade

sudo pacman -S --noconfirm zsh

chsh -s /bin/zsh
