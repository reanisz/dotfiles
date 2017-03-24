sudo cp arch/mirrorlist /etc/pacman.d/mirrorlist
sudo pacman -S --noconfirm archlinux-keyring
sudo pacman -Syu --noconfirm

sudo pacman -S --noconfirm zsh

sudo chsh -s /bin/zsh
