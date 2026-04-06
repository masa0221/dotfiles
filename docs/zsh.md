# zsh 設定ガイド

このドキュメントは、zsh 設定の構成と運用ルールをまとめたものです。

## 目的

- `~/.zshenv` は最小限に保つ（全 zsh で読み込まれるため）
- `~/.zprofile` でログインシェル向けの環境初期化を行う
- `~/.zshrc` で対話シェル向けの重い設定（zinit/p10k 等）を扱う
- AI Agent 用には軽量な設定を使えるようにする
- シークレットをリポジトリ外へ分離する

## ファイル構成

- `.zshenv`
  - 最小 PATH（例: `~/.local/bin`）のみ
- `.zprofile`
  - `~/.zsh/env.d/*.zsh` を番号順で読み込み
  - `~/.zsh/secrets.zsh` を任意読み込み
- `.zshrc`
  - 通常は従来の対話設定を読み込み
  - `CURSOR_AGENT` / `ANTIGRAVITY_AGENT` / `CODEX_SANDBOX` がある場合は軽量モードで早期終了
- `zsh/functions.zsh`
  - `~/.zsh/functions.zsh` にリンクされ、共通関数（tmux 補助など）を提供
- `zsh/env.d/`
  - `00-path.zsh`: Homebrew と基本 PATH
  - `10-toolchains.zsh`: asdf / bun / krew / php / mysql-client
  - `20-optional.zsh`: OrbStack、任意 PATH、JVM オプションなど
- `zsh/agent-zdotdir/.zshrc`
  - `ZDOTDIR` を使う Agent 用の軽量 `.zshrc`
- `zsh/secrets.zsh.example`
  - 機密情報のテンプレート（実体はリポジトリ外）

## セットアップ

```bash
cd ~/dotfiles
bash setup.sh
```

`setup.sh` で以下を配置/リンクします。

- `~/.zshenv`, `~/.zprofile`, `~/.zshrc`
- `~/.zsh/functions.zsh`
- `~/.zsh/env.d/*.zsh`
- `~/.zsh/agent-zdotdir`（存在時）

## secrets の設定（必須）

```bash
cp ~/dotfiles/zsh/secrets.zsh.example ~/.zsh/secrets.zsh
$EDITOR ~/.zsh/secrets.zsh
```

- `~/.zsh/secrets.zsh` はリポジトリにコミットしません
- 既存トークンを平文で置いていた場合は、必ずローテーションしてください

## 人間用シェルと AI 用シェル

### 人間用（通常）

- ログインシェル: `.zprofile` + `.zshrc` が効く
- 非ログイン対話: `.zshrc` が効く

### AI Agent 用（軽量）

- `.zshrc` の先頭で Agent 環境変数を検知し、重い初期化をスキップ
- ただし `env.d` は読み込むため、主要コマンドの PATH は維持

`ZDOTDIR` を使う運用をする場合は、`~/.zsh/agent-zdotdir/.zshrc` を利用してください。

## 動作確認コマンド

### 主要コマンドの PATH 確認

```bash
zsh -il -c 'for c in brew git tmux asdf bun php mysql kubectl gh; do command -v "$c" || echo "NG $c"; done'
zsh -i  -c 'for c in brew git tmux asdf bun php mysql kubectl gh; do command -v "$c" || echo "NG $c"; done'
CURSOR_AGENT=1 zsh -i -c 'for c in brew git tmux asdf bun php mysql kubectl gh; do command -v "$c" || echo "NG $c"; done'
```

### 起動時間の確認

```bash
for i in $(seq 1 10); do time zsh -i -c exit; done
for i in $(seq 1 10); do time zsh -il -c exit; done
for i in $(seq 1 10); do time CURSOR_AGENT=1 zsh -i -c exit; done
```

## 運用メモ

- 新しいツール追加は `zsh/env.d/10-toolchains.zsh` または `zsh/env.d/20-optional.zsh` へ
- 全環境で必須の最小 PATH は `zsh/env.d/00-path.zsh` へ
- `~/.zshenv` は重くしない
