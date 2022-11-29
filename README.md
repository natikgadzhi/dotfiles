# dotfiles

After cloning this repository, run `./install` to apply the dotfiles.

After installing Homebrew, run `brew bundle install` in this directory to install all software. This configuration does not support App Store applications yet, so some apps will be missing.

## Raycast

Raycast does not support automatic settings import or using settings from file. So you'll have to apply the settings manually.

**Note**: Raycast config is using `yubico-auth.sh` script command that is currently just a shell file in this repo, but should be put in `~/src/raycast/` to work correctly.
