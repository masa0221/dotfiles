# dotfiles

個人用 dotfiles 一式です。zsh / tmux / vim / git などの設定をこのリポジトリで管理し、`setup.sh` でホームディレクトリへ反映します。

## セットアップ

```bash
cd ~/dotfiles
bash setup.sh
```

`setup.sh` は主に以下をシンボリックリンクします。

- `~/.zshenv`, `~/.zprofile`, `~/.zshrc`
- `~/.zsh/functions.zsh`, `~/.zsh/env.d/*`, `~/.zsh/agent-zdotdir`（存在時）
- `~/.tmux.conf`, `~/.vimrc`, `~/.ideavimrc`, `~/.gitconfig`, `~/.gitignore`

## このリポジトリで管理している主なファイル

- **Shell**: `.zshenv`, `.zprofile`, `.zshrc`, `zsh/`
- **Terminal**: `.tmux.conf`
- **Editor**: `.vimrc`, `.ideavimrc`
- **Git**: `.gitconfig`, `.gitignore`
- **Package**: `Brewfile`

## ドキュメント

- zsh 構成・AI Agent 向け軽量モード・運用手順: [docs/zsh.md](docs/zsh.md)

## セキュリティ

- 機密情報はリポジトリに含めません
- `zsh/secrets.zsh.example` を参考に `~/.zsh/secrets.zsh` を各端末で作成してください
- 過去に平文トークンを置いていた場合は、必ずローテーションしてください

