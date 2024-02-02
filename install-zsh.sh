#!/bin/bash

# Remove existing zsh config
sudo rm -rf /root/.oh-my-zsh

# Install Zsh
sudo apt-get update
sudo apt-get install -y zsh

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Git
sudo apt-get install -y git

# Install Zsh vi-mode plugin
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.oh-my-zsh/custom/plugins/zsh-vi-mode

# Change the default shell to Zsh
chsh -s $(which zsh)
