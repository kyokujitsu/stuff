echo "settings up zsh shell"

sed -i '/s/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo LANG=de_DE.UTF-8 > /etc/locale.conf
echo KEYMAP=de-latin1-nodeadkeys > /etc/vconsole.conf
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

wget https://raw.githubusercontent.com/kyokujitsu/stuff/master/zshrc -O ~/.zshrc && source .zshrc

#git clone https://github.com/ryanoasis/nerd-fonts.git && cd nerd-fonts && ./install.sh
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git && cd awesome-terminal-fonts && ./install.sh
cd $HOME
sed -i "s/POWERLEVEL9K_MODE='nerdfont-complete'/POWERLEVEL9K_MODE='awesome-fontconfig'/" .zshrc

git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
echo "set backspace=2 
set whichwrap+=<,>,h,l,[,]" >>~/.vim_runtime/my_configs.vim
