# dotfiles

Jared's Mac configuration, symlinked into place.

| File | Lives at | What it is |
|---|---|---|
| `zshrc` | `~/.zshrc` | Shell setup: brew/fnm/pnpm PATH, prompt, history, aliases |
| `gitconfig` | `~/.gitconfig` | Git behaviors (rebase/push defaults); identity comes from an untracked `~/.gitconfig.local` |
| `gitignore_global` | `~/.gitignore_global` | Global git ignores |
| `karabiner/` | `~/.config/karabiner` | 8BitDo Micro controller mappings + `assets/cycle-apps.sh` app cycler |

## Install on a new machine

```sh
git clone git@github.com:<me>/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` symlinks everything into place (it backs up any existing file to `<name>.pre-dotfiles` first).

The whole `karabiner/` directory is symlinked (not just `karabiner.json`) because
Karabiner-Elements rewrites the file atomically on save, which would replace a
file-level symlink with a plain file.
