#!/usr/bin/env bash

echo "Are you sure you want to install my (TechTycho's) dotfiles on your machine."
printf "There is no going back! y/N: "
read yes_or_no

if [ $yes_or_no = "y" ] || [ $yes_or_no = "Y" ] || [ $yes_or_no = "yes" ] || [ $yes_or_no = "Yes" ]
then
  echo "You chose to continue the operation."
else
  echo "You chose to abort the operation."
  exit 0
fi

cd ~

echo "Checking if the directory '~/dotfiles' already exists.."

if [[ -d ~/dotfiles ]]
then
  echo "Directory '~/dotfiles' exists on your system. What do you want to do?"
  echo "1. Clone to a different repository."
  echo "2. Move or Rename the directory."
  echo "3. Delete and override the directory."
  echo "4. Abort, I'll figure things out myself."
  read action_if_dir_exists

  case $action_if_dir_exists in
	1)
	  echo "What do you want to name the new directory?"
	  read alt_dir
	  git clone https://github.com/techtycho/dotfiles $alt_dir
	  ;;
	2)
	  printf "New path: "
	  read new_existing_dir_path
	  mv ~/dotfiles $new_existing_dir_path
	  git clone https://github.com/techtycho/dotfiles
	  ;;
	3)
	  printf "Are you sure? y/N: "
	  read delete_dir_yes_or_no
	  if [ $delete_dir_yes_or_no = "y" ] || [ $delete_dir_yes_or_no = "Y" ] || [ $delete_dir_yes_or_no = "yes" ] || [ $delete_dir_yes_or_no = "Yes" ]
	  then
		echo "Deleting directory.."
		rm -r ~/dotfiles
		echo "Directory deleted successfully!"
		git clone https://github.com/techtycho/dotfiles
	  else
		echo "You choose to not delete the existing directory. Aborting.."
		exit 0
	  fi
	  ;;
	4)
	  echo "Aborting.."
	  exit 0
  esac
else
  git clone https://github.com/techtycho/dotfiles
  cd ~/dotfiles
  
  printf "Do you want to extract the icon themes? Y/n: "
  read icons_install
  if [ $icons_install = "y" ] || [ $icons_install = "Y" ] || [ $icons_install = "yes" ] || [ $icons_install = "Yes" ]
  then
	cd .icons/
	tar -Jxvf oomox-aesthetic-dark.tar.xz # Dark
	tar -Jxvf oomox-aesthetic-light.tar.xz # Light
	echo "You will need sudo privileges for this one."
	sudo cp -r oomox-aesthetic-dark oomox-aesthetic-light /usr/share/icons/
  fi

  printf "Do you want to install my configuration of AwesomeWM? Y/n: "
fi
