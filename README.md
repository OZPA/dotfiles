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

### 1-2. Homebrewのインストール（M1 Mac以降）
M1以降のMacではHomebrewのインストール方法が変更されているため、下記を参考にインストール。
参考 : https://zenn.dev/ik11235/scraps/17d44ec45ea8f7

## 2. Install
インストールされるのは以下。
* dotfiles
* Homebrew & tap,cask
* fish & fisher

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

---

## Other

### fishへの切り替え
```
# fishのパスを確認
$ which fish
/opt/homebrew/bin/fish

# 末尾に　/opt/homebrew/bin/fish を追加
$ sudo vi /etc/shells

# fishにシェル変更
$ chsh -s /opt/homebrew/bin/fish
```

### HackGen_NF のインストール
iTermおよびプログラミング用のフォント（HackGen）をインストール。
https://github.com/yuru7/HackGen?tab=readme-ov-file

### imgcatが動かない時
```
https://iterm2.com/utilities/imgcat でシェルスクリプトを全部コピー。

$ sudo vi /usr/local/bin/imgcat
上記スクリプトをペースト＆保存

# imgcatを通常コマンドとして使えるようにファイルの権限を変更
$ sudo chmod +x /usr/local/bin/imgcat
```

### Update

#### Homebrewのアップデート（Brewfileの上書き）
```
bash ~/dotfiles/setup.sh brew_update
```

#### fisherのアップデート
```
# fisher.fish にpluginを記述後
bash ~/dotfiles/setup.sh fisher_update
```

### iTerm2の設定ファイル
* `com.googlecode.iterm2.plist` が設定ファイル。  
iTerm2 の Preferences -> General -> Preferences ->Load Preferences from a custom folder or URL にチェックを入れ、dotfilesディレクトリにある `com.googlecode.iterm2.plist` を指定する。
  + もし反映されない場合は `git reset --hard ^HEAD` でplistファイルをリセットすると良いかも。
---

## After Install
### Clipy
`lib/clipy/snippets.xml` をclipyに反映

### Google日本語入力
`lib/Google日本語入力/OZPA_dic.txt` をGoogle日本語入力の辞書に反映


## 注意事項
* `brew cask` が動かなくなる（ `brew install cask ~` が推奨になる）のでどこかで直す
* `fish balias` が動かない場合は `fisher add(install) oh-my-fish/plugin-balias` でインスコ
