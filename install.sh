#!/usr/bin/env bash

# Clone the repository
cd ~ # Go to home directory

echo "Checking if the directory '~/dotfiles' already exists.."

if [[ -d ~/dotfiles ]]
then
  echo "Directory '~/dotfiles' exists on your system. What do you want to do?"
  echo "1. Clone to a different repository."
  echo "2. Move or Rename the directory."
  echo "3. Delete and override the directory."
  echo "4. Exit, I'll figure thing out myself."
  read action_if_dir_exists
fi

case $action_if_dir_exists in
  1)
	echo "What do you want to name the new directory?"
	read alt_dir
	git clone https://github.com/techtycho/dotfiles $alt_dir # Clone the repository
	;;
esac

git clone https://github.com/techtycho/dotfiles # Clone the repository
