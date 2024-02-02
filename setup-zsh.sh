#!/bin/bash

sed -i 's/plugins=(/plugins=(vi-mode /' ~/.zshrc

echo "VI_MODE_SET_CURSOR=true" >> ~/.zshrc

echo 'alias ls="eza --icons"' >> ~/.zshrc

echo 'alias ll="eza --icons -l"' >> ~/.zshrc

source ~/.zshrc
