#!/bin/bash

echo -e "\n**** Lagre en  .gitconfig inn i VM ****\n"
cat <<EOL >> ~/.gitconfig
[user]
  name = YOUR_NAME_HERE
  email = your.mail@he.re
[color]
  diff = auto
  status = auto
  branch = auto
  interactive = auto
  ui = auto
[gc]
  auto = 1
[merge]
  summary = true
[alias]
  co = checkout
  ci = commit -v
  st = status
  cp = cherry-pick -x
  rb = rebase
  pr = pull --rebase
  br = branch
  b = branch -v
  r = remote -v
  t = tag -l
  put = push origin HEAD
  unstage = reset HEAD
  uncommit = reset --soft HEAD^
  recommit = commit -C head --amend
  dc = diff --cached
  pr = pull --rebase
  ar = add -A
EOL

echo -e "\n**** Install and enable Oh my zsh! ****\n"
touch ~/.zshrc
sudo apt-get -y install zsh
sudo apt-get -y install curl
sudo apt-get -y install tree

sudo chsh vagrant -s /bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh::g' | sed 's:chsh -s .*$::g')"

echo -e "\n**** Preparing the environment ****\n"
sudo apt-get -y install maven
sudo apt-get -y install gedit

mkdir code
cd code
git clone https://github.com/WeIgniteTech/the-weignitetech-program.git  


echo -e "\n**** \n**** Installation is done!!!\n**** \n"
echo -e "\n\n"
echo -e "\n\n"
echo -e "\n Things todo in the Guest VM:\n"
echo -e " - Check keyboard mapping\n"
echo -e "  you might need to run the following command in the Guest VM to ajust keyboard mapping: \n"
echo -e "    sudo dpkg-reconfigure keyboard-configuration \n"
echo -e "\n"
echo -e " - Open web-browser from the task bar and make Chrome your default browser\n"


