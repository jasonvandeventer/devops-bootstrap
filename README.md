# DevOps Bootstrap Script

A modular, fully-automated bootstrapper to configure a fresh Ubuntu (Minimal) installation into a full-featured DevOps environment. Ideal for laptops, virtual machines, and local sandboxes.

## 🚀 Features

- 🧰 Installs core DevOps tools: Docker, AWS CLI, Terraform, kubectl, Minikube
- 💻 Enhances terminal with Zsh + Powerlevel10k + plugins
- 🧠 Displays Git & Kubernetes context in your prompt
- 📦 Adds essential CLI tools: `htop`, `bat`, `fzf`, `zoxide`, `tree`, `nmap`, etc.
- 🌍 Installs Brave browser, Warp terminal, and Visual Studio Code (GUI installs)
- 🔐 Installs and configures GitHub CLI (`gh`) with login support
- 🧹 Modular design for clarity, reusability, and custom setups

## 🛠️ Usage

### Step 1: Clone this repo

```bash
git clone https://github.com/youruser/devops-bootstrap.git
cd devops-bootstrap
```

### Step 2: Run the bootstrap

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

### Step 3: Reboot

Some changes (e.g., Docker group, Zsh shell) require you to log out or reboot.

```bash
sudo reboot
```

## 📁 Script Breakdown

| Script Name             | Description                                     |
|-------------------------|-------------------------------------------------|
| `bootstrap.sh`          | Orchestrates full setup                         |
| `install_packages.sh`   | Core CLI + utilities + networking tools         |
| `install_browsers.sh`   | Installs Brave browser                          |
| `install_terminal.sh`   | Installs Warp Terminal                          |
| `install_devops_tools.sh` | Docker, AWS CLI, Terraform, kubectl, Minikube |
| `setup_zsh.sh`          | Zsh, Oh My Zsh, Powerlevel10k, plugins          |
| `setup_dotfiles.sh`     | Sets up `.zshrc` with aliases and context       |
| `install_vscode.sh`     | Installs Visual Studio Code                     |
| `github_setup.sh`       | Installs GitHub CLI and handles auth            |

## 📎 Notes

- Make sure you're on a fresh or minimal Ubuntu system with sudo privileges.
- GUI tools (Brave, Warp, VS Code) will require a desktop environment.
- Your API keys and secrets should **not** be hard-coded. This script doesn’t store or expose sensitive credentials.

## 🧠 Customization

Feel free to remove or comment out any sections in `bootstrap.sh` if you want a lighter setup.

---

**License:** MIT  
**Author:** Jason Vandeventer (@jasonvandeventer)
