# alchelmy

[English Version](readme.md)

Alchemyはシングルページアプリケーションを作るための実験的なコードジェネレータです。

![Alchemist Sendivogius](docs/Alchemik_Sedziwoj_Matejko.JPG)

## 概要/動機

[The Elm Architecture](https://guide.elm-lang.org/architecture/)はシングルページアプリケーションに適したシンプルでわかりやすいアーキテクチャですが、アプリケーションにページを追加するときには、退屈なボイラープレートをたくさん書く必要があります。たとえば、Mainモジュールで、インポート文を追加し、


 You need to add import declarations, add data constructor to hold `Msg` from child in parent `Msg`, add routes in routing and so on. alchelmy try to generate those boilerplates automatically.

In PHP, to add a new page, all you need is adding a single `Foo.php` in your project. In a like manner, in Alchelmy, all you need is adding only `<PageName>.elm` and writing few codes in it. You don't need to tweak a lot of huge `case-of` branches by hand any more.

In essense, the behavior of Alchelmy is very simple: alchelmy generates only one source file named **`Alchemly.elm`**. This is the Elm codes that orchestrates Web pages written in Elm.

This project is highly experimental, so your comments or suggestions are welcome.

## Working Sample Application

Please see [example](example) and the automatically generated [Alchelmy.elm](https://github.com/aratama/alchelmy/blob/master/example/src/Alchelmy.elm) for more information. You can also check out the example app at the following url:

- https://alchelmy.netlify.com/

## Usage

### Defining page modules





### Installation

alchelmy isn't in NPM yet. You can use `npm i aratama/alchelmy` to install alchelmy locally and `npx alchelmy` to execute alchelmy from CLI. You can also run alchelmy via `npx aratama/alchelmy`. You also need to install `elm/browser`, `elm/json` and `elm/url` in your project dependencies in advance.

### Command Line Interfaces

alchelmy has a command line interface:

- `alchelmy init <application>` will generate `src/<Application>` directory and make some scaffolds.
- `alchelmy update` will (re)generate `src/<Application>/Alchemy.elm`.
- `alchelmy new <page>` will generate a new page named `<page>`.



#### ページの追加

```
$ npx alchelmy new <page>
```

たとえばコマンド`npx alchelmy new Hello`を実行すると、デフォルトでは`src/Page/Hello.elm`が作成されてページとして追加されます。
ページを削除するには、当該モジュールを削除します。



#### ページの定義

ページは各モジュールで次のようなデータ型`Page`の値として定義されます。

```elm
type alias Page model msg route a =
    { init : Value -> Url -> Key -> route -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , onUrlChange : Url -> route -> msg
    , route : Parser (route -> a) a
    , session : model -> Value
    }
```

この`Page`型は[Browser.application](https://package.elm-lang.org/packages/elm/browser/latest/Browser#application)に渡す最初の引数と一部が共通していますが、いくつかプロパティが追加されています。`route`プロパティはページごとのルーティングを行います。URLに対してこの`route`を使ったパースが成功すると、そのページへ遷移して`init`関数が呼ばれてページが初期化されます。

アプリケーションが起動された直後の最初に表示されるページでは、`init`の最初の引数にはフラグが渡されます。他のページから遷移してきた場合は、他のページで生成されたセッション情報が渡されます。

各ページではこの`Page`型を使ってページを型注釈を付けることが推奨されますので、何らかの共通モジュールを用意してそこにこの`Page`を定義し、各ページから参照するといいでしょう。`Alchelmy.elm`はこの`Page`型を参照しないので、どこに記述しても構いません。



### ページの遷移

ページ間を遷移するには、`pushUrl`コマンドを呼び出します。`pushUrl`でURLを変更した場合、そのページの`onUrlChange`メッセージが送信されて、状態の更新とコマンドの実行が行われます。ここまでは通常のアプリケーションと同様です。そのあと、そのURLに対してそのページの`page.route`でそのURLのパースを試みます。もしパースが成功すればページは遷移しません。それに対して、パースが失敗した場合は再度ルーティングが行われ、遷移先のページが選定され、遷移先の`page.init`が呼び出されてページが初期化されます。

### ページ間でのデータ受け渡し

ページの遷移が発生すると、まず遷移前のページの`page.session`を呼び出してセッション情報を取得します。そのセッション情報が遷移先の`page.init`へと渡されてページが初期化されます。

ページ間でのデータの受け渡しに使われるデータ型は`Json.Encode.Value`であるため、JSONデータとして表現できないデータは遷移先のページへと引き継ぐことはできません。


### 各ページでの共通部分

Alchelmyは、各ページで共通の`view`や`update`などを提供しません。複数のページで共通の振る舞いが必要であれば、`example`を参考にしてください。


### グローバルなメッセージのハンドリング

通常、`Alchelmy.program`を使用してアプリケーション全体を初期化しますが、`Alchelmy.elm`は`update`や`view`などもエクスポートしており、これらを直接インポートしてアプリケーションを構成することもできます。




## Building Alchelmy Itself

```sh
$ npm i
$ npm run build
```

## Known Limitations

- You can't specify order of precedence of routes. You should take care not to overlap routings.

## Comparison to Other Projects

There are some simillar projects:

- [elm-spa](https://www.elm-spa.dev/guide)
- [elm-pages](https://elm-pages.com/)
- [Spades](https://github.com/rogeriochaves/spades)

## References

- [Matejko, "Alchemist Sendivogius"](https://commons.wikimedia.org/wiki/File:Alchemik_Sedziwoj_Matejko.JPG)
