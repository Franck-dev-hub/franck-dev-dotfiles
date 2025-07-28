# 👋 Welcome to my Linux dotfiles repository

<p>
Welcome to my dotfiles repository. It's clean, minimal, and... yes, I use Arch btw.<br>
Fork it, tweak it, and make it yours!
</p>

## 🧰 Repository Contents

<p>
Below are the main configurations included.<br>
Click on the 
<a href="https://img.shields.io"><img src="https://img.shields.io/badge/badges-89B4fA"></a> to visit the official repositories and give them all your love 💖.
</p>
  
| Technology | Component             | Description              |
|------------|-----------------------|--------------------------|
| [![Arch Linux](https://img.shields.io/badge/I_use-Arch_btw-1793D1?logo=arch-linux&logoColor=fff)](https://youtu.be/YC7NMbl4goo?si=uO8MuaLw8SserROU) | | |
| [![Zsh](https://img.shields.io/badge/Zsh-F15A24?logo=zsh&logoColor=fff)](https://github.com/ohmyzsh/ohmyzsh) | `~/.zshrc` | Zsh shell configuration |
| [![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=fff)](https://github.com/neovim/neovim) | `~/.config/nvim` | Text editor |
| [![Waybar](https://img.shields.io/badge/Waybar-7C3AED?logo=waybar&logoColor=fff)](https://github.com/Alexays/Waybar) | `~/.config/waybar` | Status bar for Wayland |
| [![Hyprland](https://img.shields.io/badge/Hyprland-00D9FF?logo=hyprland&logoColor=000)](https://github.com/hyprwm/Hyprland) | `~/.config/hypr` | Window manager |
| [![Mako](https://img.shields.io/badge/Mako-4CAF50?logo=linux&logoColor=fff)](https://github.com/emersion/mako) | `~/.config/mako` | Notification daemon |
| [![Fastfetch](https://img.shields.io/badge/Fastfetch-FF6B6B?logo=linux&logoColor=fff)](https://github.com/fastfetch-cli/fastfetch) | `~/.config/fastfetch` | System info in terminal |
| [![Ghostty](https://img.shields.io/badge/Ghostty-2D3748?logo=terminal&logoColor=fff)](https://github.com/mitchellh/ghostty) | `~/.config/ghostty` | Terminal emulator |
| [![Rofi](https://img.shields.io/badge/Rofi-FF9500?logo=linux&logoColor=fff)](https://github.com/davatorium/rofi) | `~/.config/rofi` | Application launcher    |
| [![Oh My Posh](https://img.shields.io/badge/Oh_My_Posh-FF69B4?logo=powershell&logoColor=fff)](https://github.com/JanDeDobbeleer/oh-my-posh) | `~/.config/ohmyposh`     | Terminal prompt theme |
| [![Sublime Text](https://img.shields.io/badge/Sublime_Text-FF9800?logo=sublime-text&logoColor=fff)](https://github.com/SublimeText) | `~/.config/sublime-text` | GUI text editor |

## 🚀 Quick Installation

> ⚠️ These configurations are primarily tested on [![Arch Linux](https://img.shields.io/badge/Arch-Linux-1793D1?logo=arch-linux&logoColor=fff)](#). They may require adjustments for other distributions.

<details>
  <summary><h3>🔧 Installation Steps</h3></summary>

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Backup Your Existing Configs (Recommended)

```bash
cp ~/.zshrc ~/.zshrc.backup
cp -r ~/.config ~/.config.backup
```

### 3. Backup your files

```bash
cp .zshrc ~/
cp -r .config/* ~/.config/
```

### 4. Install Dependencies

<details>
  <summary><strong>💠🐧 Arch 🐧💠</strong></summary>

```bash
sudo pacman -S zsh neovim waybar hyprland mako fastfetch rofi ttf-nerd-fonts-symbols oh-my-posh
```

</details>
<details>
  <summary><strong>🌀🐧 Debian 🐧🌀</strong></summary>

```bash
sudo apt update
sudo apt install zsh neovim waybar hyprland mako-bin fastfetch rofi fonts-nerd-fonts oh-my-posh
```

</details>
<details><summary><strong>🐾🐧 Fedora 🐧🐾</strong></summary>
  
```bash
sudo dnf install zsh neovim waybar hyprland mako fastfetch rofi nerd-fonts-ttf oh-my-posh
```
</details>
</details>

## 📁 Git Structure

This repository uses an inverted `.gitignore` pattern to track only essential config files and ignore the rest.

## 🙌 Notes

- Make sure to adapt paths and configs to match your specific system setup.
- Contributions, suggestions, or forks are always welcome!

## 📜 License

This project is licensed under the **GNU GPL v3.0**. See the LICENSE file for more information.

## 💖 Acknowledgments

Big thanks to the Linux community and everyone who shares their knowledge and tools.
