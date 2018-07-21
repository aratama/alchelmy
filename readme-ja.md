# elm-automata

**elm-automata** は、複数のページからなるシングルページアプリケーションの、ボイラープレート部分を自動的に生成するスクリプトです。`elm-automata`コマンドを実行すると、ページのルーティングを行う`Routing.elm`というモジュールを自動的に生成します。

## 使いかた

### ページの生成

`elm-automata new <PageName>`コマンドを実行すると、`src/<Application>/Page/`ディレクトリの中に`<PageName>`という名前の新たなディレクトリが作成され、その中に`style.css`、`View.elm`, `Update.elm`, `Type.elm`という4つのファイルが作成されます。

新たなページを作成したり、ページの名前を変更した場合は、`elm-automata`コマンドを実行して`Routing.elm`を再生成してください。(なお、`elm-automata new`コマンドでページを作成した場合は、自動的に`Routing.elm`が再生成されます。)

もちろん、`elm-automata new`コマンドを使わずにページを追加することもできますが、その場合も同様の規約に従ってモジュールを定義する必要があります。

### グローバルな状態の定義

elm-automataでは、アプリケーション全体に関わる設定など、各ページに共通する状態を使うことができます。この状態の型は、`src/<Application>/Type.elm`モジュールで`Model`という名前で定義してください。これは、たとえ共通する状態が必要なくても定義する必要があります。実際の例は[example/src/CoolSPA/Type.elm](example/src/CoolSPA/Type.elm)を参照してください。

### アプリケーションの初期化

`Routing.elm`は`program`関数をエクスポートします。これはグローバルな状態の初期状態を引数に取り、`Program Never Model Msg`を返します。アプリケーションをもっとも簡単に初期化するには、この`program`に初期状態を与えて`main`を定義します。実際の例としては、実際の例は[example/src/Main.elm](example/src/Main.elm)を参照してください。なお、`Routing.elm`は`init`、`view`、`update`、`subscriptions`も個別にエクスポートするので、必要に応じてこれらを使うこともできます。

### ルータの生成

`elm-automata`コマンドを実行すると、`src/<Application>/Page/`ディレクトリ以下のディレクトリを調べ、少なくとも`style.css`、`View.elm`, `Update.elm`, `Type.elm`の４つのファイルを持っているディレクトリがあると、それらのモジュールを『ページ』として認識し、`Routing.elm`を生成します。ページはネストすることができます。


## 既知の制限

* ルーティングの優先順位を指定することができません