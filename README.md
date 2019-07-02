# OZPA's dotfiles

## Overview
新しいMacのセットアップ用dotfilesです。
下記の手順でセットアップしましょう。

## 0. Prerequisites
XCodeをコマンドラインツールでインストール。

```
xcode-select --install
```

## 1. Git Clone
```
git clone https://github.com/OZPA/dotfiles.git ~/dotfiles
```

## 2. Install
インストールされるのは以下。
* dotfiles
* Homebrew & tap,cask

```
bash ~/dotfiles/setup.sh initialize
```

## 3. Deploy
Deploy（シンボリックリンク作成）します。

```
# Do not override existing dotfiles
bash ~/dotfiles/setup.sh deploy

# Force override existing dotfiles
bash ~/dotfiles/setup.sh -f deploy
```