# dotfiles

After cloning this repository, run `./install` to apply the dotfiles, that will work for both Mac and Linux boxes.


## Mac

This repository is structured to provide a way to roll dotfiles for generic Unix boxes, and then some extra settings for Mac systems:

- `./install` to setup dotfiles.
- `brew bundle install` to install most apps on a Mac. This will install apps from both Casks, and Mac App Store.
- `mackup restore` will restore most Mac-specific settings from this repository. Settings are backed up in `mackup` folder.

## Raycast

**Note**: Raycast config is using `yubico-auth.sh` script command that is currently just a shell file in this repo, but should be put in `~/src/raycast/` to work correctly.
