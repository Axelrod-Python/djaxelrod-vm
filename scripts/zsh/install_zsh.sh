apt-get install -y zsh
su -c "curl https://raw.githubusercontent.com/meatballs/dotfiles/master/install.sh > ~/install.sh" vagrant
su -c "chmod 774 ~/install.sh" vagrant
su -c "~/install.sh" vagrant
su -c "cp -f /tmp/zsh_settings.zsh ~/.local_settings.zsh" vagrant
chsh -s /bin/zsh vagrant
su -c "source ~/.zshrc" vagrant
