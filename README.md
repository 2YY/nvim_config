# Neovim 設定

## TODO

- 補完
- テスト
- (デバッガ)

## 構成

### プラグインマネージャー

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
  - [Structured Setup](https://lazy.folke.io/installation) を採用。
  - `lua/plugins` ディレクトリ配下に、インストールしたいプラグインのリストを記述する。
    - プラグインをカテゴリに分けて、カテゴリ毎にファイルを分割して記述する。(後で何がどこに有るか探しやすい)
  - 新規追加したものをインストールや、バージョンアップしたい時は、`:Lazy update` を実行。
  - プラグインの設定から何か削除した時は、`:Lazy clean` で、使わなくなったプラグインのファイルをローカルから削除できる。

### LSP・リンター

- [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim)
  - [mason-org/mason.nvim](https://github.com/mason-org/mason-lspconfig.nvim) で、事前に必ずインストールしておきたいものを設定出来るようにしている。(`lua/plugins/lsp.lua`)
