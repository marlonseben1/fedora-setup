#!/bin/bash

DOTFILES_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

echo " --- Starting the setup --- "

# 1. Setting up Antigravity and friends
sudo tee /etc/yum.repos.d/antigravity.repo << EOL
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOL

sudo dnf makecache
sudo dnf upgrade -y
sudo dnf install -y git zsh util-linux-user curl antigravity

# 2. Setting Zsh as the default terminal
sudo chsh -s $(which zsh) $USER

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Installing pnpm 

curl -fsSL https://get.pnpm.io/install.sh | sh -

# 4. Linking configuration files for Zsh

ln -sf "$DOTFILES_DIR/config/.zshrc" "$HOME/.zshrc"

# 5. Installing Node and TypeScript globally
export PATH="$HOME/.local/share/pnpm:$PATH"
PNPM_BIN="$HOME/.local/share/pnpm/pnpm"
$PNPM_BIN env use --global lts
$PNPM_BIN add -g typescript

# 6. Idiom setup (English)
sudo localectl set-locale LANG=en_US.UTF-8

# 7. Installing and setting up Antigravity

ANTIGRAVITY_USER_DIR="$HOME/.config/Antigravity/User"
mkdir -p "$ANTIGRAVITY_USER_DIR/snippets"
ln -sf "$DOTFILES_DIR/config/settings.json" "$ANTIGRAVITY_USER_DIR/settings.json"
ln -sf "$DOTFILES_DIR/config/keybindings.json" "$ANTIGRAVITY_USER_DIR/keybindings.json"

if [ -d "$DOTFILES_DIR/config/snippets" ]; then
    ln -sf "$DOTFILES_DIR/config/snippets/"* "$ANTIGRAVITY_USER_DIR/snippets/"
fi

# 8. Installing SF Pro Font
if [ -d "$DOTFILES_DIR/fonts" ]; then
    mkdir -p ~/.local/share/fonts
    cp -r "$DOTFILES_DIR/fonts/"* ~/.local/share/fonts/
    fc-cache -f
fi

# 9. Setting up the theme I am currently using
sudo dnf install -y sassc optipng inkscape

git clone https://github.com/vinceliuice/WhiteSur-kde.git /tmp/WhiteSur-kde
/tmp/WhiteSur-kde/install.sh --dest "$HOME/.local/share/aurorae/themes"

lookandfeeltool -a com.github.vinceliuice.WhiteSur-dark

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git /tmp/WhiteSur-icons
/tmp/WhiteSur-icons/install.sh -a

echo " --- Setup finished --- "