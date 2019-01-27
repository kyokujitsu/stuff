git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
echo "set backspace=2
set whichwrap+=<,>,h,l,[,]" >>~/.vim_runtime/my_configs.vim
git clone https://github.com/Yggdroot/indentLine.git ~/.vim_runtime/my_pluings/vim-indentLine
