#!/usr/bin/env zsh 

# get logged-in user
loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# use find to get the dotfile filenames
# loop through to create symlinks
for dotFile in `find ./system -type f -exec basename {} \;`
do
  echo "Creating symlink to $dotFile in home directory."
  ln -s /Users/$loggedInUser/dotfiles/system/$dotFile /Users/$loggedInUser/$dotFile
done

# Run the Homebrew Script
sh ./brew.sh

# Run the dockutil Script
sh ./dockutil.sh
