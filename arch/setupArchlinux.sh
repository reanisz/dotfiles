sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
sudo cp ./mirrorlist /etc/pacman.d/mirrorlist
sudo pacman -S --noconfirm archlinux-keyring
sudo pacman -Syu --noconfirm
sudo pacman-db-upgrade

sudo pacman -S --noconfirm zsh ctags

chsh -s /bin/zsh
sudo update-ca-trust
