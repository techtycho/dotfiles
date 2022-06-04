#!/usr/bin/env bash

# This script installs my configuration of AwesomeWM on your system.

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

printf "${BLUE}?${NC} Are you sure you want to install my (TechTycho's) dotfiles on your machine.\n"
printf "${GREEN}=>${NC} There is no going back! y/N: "
read yes_or_no

if [ $yes_or_no = "y" ] || [ $yes_or_no = "Y" ] || [ $yes_or_no = "yes" ] || [ $yes_or_no = "Yes" ]
then
  printf "${YELLOW}{}${NC} You chose to continue the operation.\n\n"
else
  printf "${YELLOW}{}${NC} You chose to abort the operation.\n"
	printf "${RED}Aborting..${NC}"
  exit 0
fi

cd ~

clone_repo () {
	printf "${YELLOW}{}${NC} Checking if the directory '~/dotfiles' already exists..\n\n"

	if [[ -d ~/dotfiles ]]
	then
	  printf "${RED}{!}${NC} Directory '~/dotfiles' exists on your system. What do you want to do?\n"
	  printf "  ${GREEN}>${NC} 1. Clone to a different repository.\n"
	  printf "  ${GREEN}>${NC} 2. Move or Rename the directory.\n"
	  printf "  ${GREEN}>${NC} 3. Delete and override the directory.\n"
	  printf "  ${GREEN}>${NC} 4. Abort, I'll figure things out myself.\n"
	  read action_if_dir_exists

	  case $action_if_dir_exists in
		1)
			alt="true"
		  printf "${GREEN}=>${NC} Choose a name for the new directory: "
		  read alt_dir
		  git clone https://github.com/techtycho/dotfiles $alt_dir
		  ;;
		2)
		  printf "${GREEN}=>${NC} New path: "
		  read new_existing_dir_path
		  mv ~/dotfiles $new_existing_dir_path
		  git clone https://github.com/techtycho/dotfiles
		  ;;
		3)
		  printf "${GREEN}=>${NC} Are you sure? y/N: "
		  read delete_dir_yes_or_no
		  if [ $delete_dir_yes_or_no = "y" ] || [ $delete_dir_yes_or_no = "Y" ] || [ $delete_dir_yes_or_no = "yes" ] || [ $delete_dir_yes_or_no = "Yes" ]
		  then
				printf "${RED}{!}${NC} Deleting directory..\n"
				rm -r ~/dotfiles
				printf "${YELLOW}{}${NC} Directory deleted successfully!\n"
				git clone https://github.com/techtycho/dotfiles
		  else
				printf "${RED}{!}${NC} You choose to not delete the existing directory. ${RED}Aborting..${NC}\n"
				exit 0
		  fi
		  ;;
		4)
		  printf "${RED}Aborting..${NC}\n"
		  exit 0
	  esac
	else
	  git clone https://github.com/techtycho/dotfiles
	  cd ~/dotfiles
	fi
}

printf "${GREEN}=>${NC} Do you want to clone the repository? y/n: "
read cloned_yes_or_no

if [ $cloned_yes_or_no = "y" ] || [ $cloned_yes_or_no = "Y" ] || [ $cloned_yes_or_no = "yes" ] || [ $cloned_yes_or_no = "Yes" ]
then
	clone_repo
fi

printf "${GREEN}=>${NC} Do you want to extract the icon themes? Y/n: "
read icons_install

if [ $icons_install = "y" ] || [ $icons_install = "Y" ] || [ $icons_install = "yes" ] || [ $icons_install = "Yes" ]
then
	if [ $alt = "true" ];
	then
		cd ~/$alt_dir
	else
		cd ~/dotfiles
	fi

	cd .icons/
	tar -Jxvf oomox-aesthetic-dark.tar.xz # Dark
	tar -Jxvf oomox-aesthetic-light.tar.xz # Light
	printf "${RED}{!}${NC} You will need sudo privileges for this one.\n"
	sudo cp -r oomox-aesthetic-dark oomox-aesthetic-light /usr/share/icons/
fi

printf "${GREEN}=>${NC} Do you want to install my configuration of AwesomeWM? Y/n: "
read awesomewm_yes_or_no

if [ $awesomewm_yes_or_no = "y" ] || [ $awesomewm_yes_or_no = "Y" ] || [ $awesomewm_yes_or_no = "yes" ] || [ $awesomewm_yes_or_no = "Yes" ]
then
	cd ~/.config/

	if [[ -d ~/.config/awesome ]];
	then
		printf "${YELLOW}{}${NC} Your old AwesomeWM config was moved to ~/.config/awesome_old.\n"
		mv awesome awesome_old
	fi

	cd ~/$alt_dir/.config/
	mv awesome ~/.config/
fi

printf "${BLUE}!!${NC} Done. Exiting.."
exit 0
