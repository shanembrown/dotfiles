#!/usr/bin/env bash

# will clean this up later; testing generic workflow for now

# get logged-in user
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

ln -s /Users/$loggedInUser/dotfiles/system/.zshrc /Users/$loggedInUser/.zshrc
ln -s /Users/$loggedInUser/dotfiles/system/.vimrc /Users/$loggedInUser/.vimrc
ln -s /Users/$loggedInUser/dotfiles/system/.aliases /Users/$loggedInUser/.aliases
ln -s /Users/$loggedInUser/dotfiles/system/.functions /Users/$loggedInUser/.functions
