#!/bin/bash
USER="dan"

# Setting up locale, keymap & time
#fix sed
sed -i 's/^[#]en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen && locale-gen
echo LANG=en_US.UTF-8 >/etc/locale.conf
echo KEYMAP=de-latin1-nodeadkeys >/etc/vconsole.conf
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
echo "[X] - locale, keymaps & time"

# Initializing pacman, updating mirrorlist, getting basic tools
pacman -Syu && pacman -S reflector
reflector -f 20 -c Germany --threads 8 -p http --score 20 -a 24 | tee /etc/pacman.d/mirrorlist
pacman -S git vim mc zsh wget curl exa sudo htop rsync base-devel fzf neovim hstr go
echo "[X] - init. pacman, mirrorlist, tools"

# Customizing zsh with powerlevel10k
cd $HOME
curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -o install.sh && bash install.sh --unattended
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
rm install.sh
echo "[X] - zsh, powervel10k, zsh-syntax-highlighting, zshrc"

# Sourcing customg .zshrc
curl https://raw.githubusercontent.com/kyokujitsu/stuff/master/zshrc >~/.zshrc

# Setting up nvim lunar
bash <(curl -s https://raw.githubusercontent.com/ChristianChiarulli/lunarvim/master/utils/installer/install.sh)
# Setting up vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
echo "set backspace=2
let g:snipMate = { 'snippet_version' : 1 }
set whichwrap+=<,>,h,l,[,]" >>~/.vim_runtime/my_configs.vim

# Setting up yay (Arch Aur Repo)
useradd -m $USER
passwd $USER
echo "[X] - added user: $USER"
echo "dan  ALL=(ALL:ALL) ALL" >>/etc/sudoers
echo "[X] - sudoer $USER added"
cd /home/$USER; sudo -u $USER git clone https://aur.archlinux.org/yay.git; cd yay; sudo -u $USER makepkg -si --noconfirm
echo "[X] - yay installed"
sudo -u $USER yay -S neovim-git
