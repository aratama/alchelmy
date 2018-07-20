# elm-generate

邪悪なシングルページアプリケーション実験

## 規約

* `<Application>.Page`ディレクトリ以下にあるディレクトリで、少なくとも`style.css`、`View.elm`, `Update.elm`, `Type.elm`の４つのファイルを持っていると、それらのモジュールがページとして認識されます。
* ページはネストすることができます。

* `style.css`はビルドするときにアプリケーションに読み込まれます。
* `Type`モジュールでは、 `Msg`、`Model`、`Route`の3つのデータ型を定義します。
* `Update`モジュールでは、`route`、`init`、`update`、`subscriptions`の４つの関数を定義します。
* `View`モジュールでは、`view : Root.Model -> Model -> Html Msg` という関数を定義します。

## 既知の制限

* ルーティングの優先順位を指定することができない