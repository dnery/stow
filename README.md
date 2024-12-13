# Misleading name

This is closer to a portable user base than just a "dotfiles" folder. Not much here yet but we'll get there. The `uncool` dir is for applications that don't support custom config locations or require too much wrestling to do so. (Hence they're banned to the `uncool` club.)

### Instructions (to self):

#### 1. Copy 'dot-shell.id.skeleton' to 'dot-shell.id' and fill out the actual values (plain key-values, no quoting)

#### 2. Install the configuration ('uncool' dir has special treatment)
```shell
./install.sh
```

#### 3. And do this before commiting new changes
```shell
nix run "nixpkgs#gitleaks" detect
```
