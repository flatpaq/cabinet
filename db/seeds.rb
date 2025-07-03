# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name_id: 'administrator',
  name: '管理者',
  email: 'admin1@sample.com',
  password: 'password',
  password_confirmation: 'password',
  introduction: '管理者',
  admin: true,
  state: true,
  indication: false
)

11.times do |n|
  User.create!(
    name_id: "user#{n + 1}",
    name: "ユーザー#{n + 1}",
    email: "user#{n + 1}@sample.com",
    password: 'password',
    password_confirmation: 'password',
    introduction: "ユーザ#{n + 1}です",
    admin: false,
    state: true,
    indication: false
  )
end

Article.create!(
  [

    # {
    #   user_id: 2,
    #   title: "Markdownの基本的な書き方",
    #   content: "",
    #   permalink: "markdown",
    #   status: 1,
    #   coedit_permit: 0,
    #   garbage: false
    # }

    {
      # ウェルカムページをちゃんと書く
      user_id: 1,
      title: 'トップページ',
      content: "

# ようこそ


このページはトップページです。誰でも自由に編集できるようになっています。

下記のように他の記事ページへのリンクを貼ることができます。

- [Sassの記法まとめ](https://flatpaq-cabinet-sample.herokuapp.com/articles/sass-basic/)
- [CrontabでLet's Encryptの証明書を自動で更新する](https://flatpaq-cabinet-sample.herokuapp.com/articles/edit-crontab)
-  [ひとまず始めるTypescript](https://flatpaq-cabinet-sample.herokuapp.com/articles/getting-started-with-typescript)
- [Vue.jsでアコーディオンを作る](https://flatpaq-cabinet-sample.herokuapp.com/articles/vue-accordion)

### Markdownの書き方

Markdownの書き方については下記の記事をご覧ください。

[ブログやドキュメントの作成に便利なMarkdownの書き方](https://flatpaq-cabinet-sample.herokuapp.com/articles/markdown/)

      ",
      status: 1,
      coedit_permit: 1,
      garbage: false
    },

    {
      # 通常のページ
      user_id: 2,
      title: 'Markdownの基本的な書き方',
      content: "

> Markdown(マークダウン)は、文書を記述するための軽量マークアップ言語のひとつである。本来はプレーンテキスト形式で手軽に書いた文書からHTMLを生成するために開発されたものである。
>
> [Wikipedia](https://ja.wikipedia.org/wiki/Markdown)

HTMLは文書データとしてユニバーサルな規格のひとつであり、WebページやWebアプリの開発だけでなく、ブログ記事を書くことにも利用されますが、記事を書く際にHTMLタグを挿入していくのはなかなか面倒だと思います。

**Markdown記法は、簡易な記述方法でHTML要素を表現できるため、ドキュメントの作成において非常に便利です。**
以下にMarkdownの書き方をまとめます。

----

- 文章を1行空けて改行すれば段落扱いとなります。HTMLだと`<p>`タグで囲われた状態です。
- 同じ段落内で改行したい場合は、行の末尾に`半角スペース`を**2つ**記入することで、ひとつ下の行が段落内改行となります。
- バックスラッシュ(`\`)をMarkdown記号の前に挿入すると、Markdownを無効化(エスケープ)することができます。

要素(セマンティクス)  | HTMLタグ  | Markdown  |  書き方の例
--|---|---|--
段落  | `<p>`  | 1行開けて改行  |  `1段落目の文章`<br><br>`2段落目の文章`
見出しレベル1  | `<h1>`  | 行頭に`#`を書いて半角スペース  |  `# これは見出しです`
見出しレベル2  | `<h2>` | 行頭に`##`を書いて半角スペース  |  `## これは見出しレベル2です`
見出しレベル3  | `<h3>` | 行頭に`###`を書いて半角スペース  |  `### これは見出しレベル3です`
見出しレベル4  | `<h4>` | 行頭に`####`を書いて半角スペース  |  `#### これは見出しレベル4です`
見出しレベル5  | `<h5>` | 行頭に`#####`を書いて半角スペース  |  `##### これは見出しレベル5です`
見出しレベル6  | `<h6>` | 行頭に`######`を書いて半角スペース  |  `###### これは見出しレベル6です`
箇条書き  | `<ul>`<br>`<li>`  | 行頭に`*`か`+`または`-`を書いて半角スペース  |  `- たまご`<br>`- キャベツ`
番号付き箇条書き  | `<ol>`<br>`<li>`  | 行頭に*数字*と`.`を書いて半角スペース  |  `1. 起きる`<br>`2. 朝食をとる`<br>`3. 散歩する`
引用  | `<blockquote>`  | 行頭に`>`を書いて半角スペース  |  `> Markdown(マークダウン)は、文書を記述するための軽量マークアップ言語のひとつである。`
斜体(強調の場合あり)  | `<em>`  | `*`で文字を囲む  | `*強調しています*`
強調  | `<strong>`  | `**`で文字を囲む  |  `**とても強調しています**`
打ち消し線  | `<del>`  | `~~`で文字を囲む  | `~~打ち消し線~~`
水平線  | `<hr>`   | `-`、`*`、または`_`を3つ以上並べる  | `--------`

## リンク

リンクは`[リンクテキスト](リンクのURL)`で使用できます。

```md
[Google](https://www.google.co.jp/)
```

[Google](https://www.google.co.jp/)

## 画像の貼り付け

画像はエディタのエリア内にドラッグ&ドロップすることで貼り付けることができます。

画像は`![画像の代替テキスト](ファイルパス/ファイル名.拡張子)`で表記されます。

## テーブル


```md
| 言語名   | 特徴                |
|:-------:|:------------------ |
| Java    | 一度書けばどこでも動く |
| PHP     | Webアプリ開発に特化   |
```

`|`記号で列(column)を区切ります。
また、`-`記号を並べて、区切った上の行をテーブルの見出しとして表現します。区切り行には、`-`や`半角スペース`はいくつ挿入されていても表示に影響はありません。
`-`の隣に付いているコロン(`:`)は、左側のみに記述すると、その列のデータが左揃え表記になり、右側のみに記述すると右揃えになります。
両側に記述すると中央揃えになります。

上記の例の出力結果は下のようになります。

| 言語名   | 特徴                |
|:-------:|:------------------ |
| Java    | 一度書けばどこでも動く |
| PHP     | Webアプリ開発に特化   |


## コードブロック

コードブロック(`<pre>`要素)を表記する場合は、バッククォート記号3つで、開始と終了の範囲をそれぞれ囲みます。

開始のバッククォート3つの直後に、拡張子またはプログラム言語名を記述すると、そのコードに合わせてシンタックスハイライトが適用されます。

```js
window.addEventListener('load', mobileMenu);

function mobileMenu() {

  let mobileMenuBtn = document.querySelector('.mobile-menu');
  let bodyShadow = document.querySelector('.wrapper');
  let sidebarActive = document.querySelector('.sidebar-cont');

  bodyShadow.classList.remove('active');
  sidebarActive.classList.remove('active');

  mobileMenuBtn.addEventListener('click', function() {
    bodyShadow.classList.toggle('active');
    sidebarActive.classList.toggle('active');
  }, false);

};
```

## インラインコード

インラインコード(`<code>`要素)を表現する場合は、開始と終了をバッククォート1つずつで囲います。

```
`ctrl` + `shift` + `alt`
```

`ctrl` + `shift` + `alt`

      ",
      permalink: 'markdown',
      status: 1,
      coedit_permit: 0,
      garbage: false
    },

    {
      user_id: 3,
      title: 'Sassの記法まとめ',
      content: "

## はじめに

SassはCSS言語の拡張言語です。以下のような特徴があります。

- ファイルをひとつにまとめること(**パーシャル**)ができる
- 処理を入れ子(**ネスト**)にできる
- **変数**が使用できる
- コードを再利用(**継承、ミックスイン**)できる
- 1行コメントを使うことができる
- ifやforなどの**制御構文**が使用できる
- **関数**を用いてプログラムのような処理ができる
- コードを圧縮できる
- Webフレームワークに標準で組み込まれていることが多い

本記事では個人的によく使用するSassの機能をまとめます。この記事に掲載している内容はSassの持つ機能の極一部ですので、その点についてはご留意ください。

## Sassの注意点

- 環境構築が必要
- ブラウザはSassファイルを読み込むことはできないため、CSSファイルに変換(トランスパイル)する必要がある
- 拡張子は`.sass`ではなく`.scss`を使うのが一般的


## Sassの主な機能


### インポート、パーシャル

CSSにも`@import`文がありますが、Sass独自の*インポート機能*は*パーシャル*と組み合わせて利用することで、CSS変換後のファイルをひとつにまとめることができます。

まず、*パーシャル(partial)*とは、**scssファイル名の先頭にアンダーバー(`_`)をつけることで、そのファイルをCSSに変換しないようにする**機能です。
`_basic.scss`のように書きます。

パーシャルとして書いた`_basic.scss`はCSSに変換されないため、このままでは書いたスタイルは反映されませんが、`@import`機能を使用することで、**他のSassファイルに取り込まれ、ひとつのファイルにまとめること**ができます。


例として、`_reset.scss`、`_basic.scss`の二つのパーシャルファイルを`main.scss`にまとめる際は下記のように記述します。
先頭の`_`や`.scss`拡張子を省略して記述します。


```scss
@import \"reset\";
@import \"basic\";
```

インポートされるSassファイルは上から順番に読み込まれます。



<h1>インポートのネスト</h1>

`@import`はネストして使うことができます。(ネストの詳しい説明は`ネスト`の項をご覧下さい。)

```scss
.old-page {
  @import \"old-style\";
}
```

上記のようにセレクタの中に`@import`文を書くことで、`_old-style.scss`内に記述されたスタイルの、全セレクタの先頭には`.old-page`がつくことになります。CSSに変換すると下記のようになります。

```css
.old-page header {
  padding: 24px;
}
.old-page footer {
  background: #fefefe;
}
```

こうすることで、例えばページのリニューアルを行う際に、古いスタイルと新しいスタイルを切り分けて作業ができるようになります。




### コメント

Sassファイルには、CSS従来のコメント文だけでなく、一行コメントの`//`が使えます。

```scss
/* CSS従来のコメント文 */
// Sassのコメント文 この行はコメントアウトされます
```

SassのコメントはCSS変換時に削除されます。CSSの従来のコメント文も、`--style compressed`オプションの場合だと削除されます。


### 変数

プログラミング言語のように、値を変数に格納することができます。

```scss
$変数名: 値;
```

上記のように**先頭に`$`をつけて記述することで、変数を宣言する**ことができます。
CSSのプロパティと値を定義するような形式で記述することで、値を変数に代入できます。

例えば下記の変数`$white-color`は下記のように利用することができます。


```scss
$white-color: #fff;
.wrapper {
  background: $white-color;
}
```


変数は基本的にプロパティの値として参照します。他の部分でも参照したい場合は*インターポレーション*を用いることで変数を参照できるようになります。詳しくは`変数や引数を柔軟に使用する(インターポレーション)`の項をご覧ください。

#### 変数の命名規則

変数名はCSSのClassやID名と同様に命名規則があります。

- 半角英数字の他にハイフン(`-`)やアンダーバー(`_`)を使用できる
- 日本語などのマルチバイト文字が利用できる
- 変数名の先頭に連続したハイフン(`--`)は使用できない
- 変数名の先頭に半角数字は使用できない


#### 変数のスコープ

変数にはスコープ(適用できる範囲)があります。
セレクタ内の波括弧(`{}`)で囲んだ中、つまりCSSルールセット内に変数が宣言されていた場合、その変数はその波括弧の外側では参照することができません。

```scss
.sidebar {
  $accent-color: #4c9aee;
}
.main {
  // ここでは$accent-colorを利用できない
  background: $accent-color;
}
```

全体で使用したい変数は`_variable.scss`といったファイルでまとめて宣言しておき、インポートする際には、`_variable.scss`を先頭に記述しておくことで他のSassファイルでも使うことができます。


```scss
$accent-color: #4c9aee;
```


```scss
@import \"variable\";
@import \"reset\";
@import \"basic\";
```

      ",
      permalink: 'sass-basic',
      status: 1,
      coedit_permit: 0,
      garbage: false
    },

    {
      user_id: 4,
      title: "CrontabでLet's Encryptの証明書を自動で更新する",
      content: "

指定したコマンドを定期実行できるcrontabの使い方をメモします。
また備忘録として、Let’s Encryptの証明書を自動で更新できるように設定したものを掲載します。

## 準備

まずサーバにログインします。
その後エディタで/etc/crontabを開き編集します。

```
ssh -p ポート番号 ユーザ名@サーバ名
nano /etc/crontab
```

## Crontab

crontabは、5つのアスタリスクとコマンド文で構成されます。

```
* * * * * コマンド
```


5つのアスタリスクは数値に変更できます。
左から順に、分(0-59)、時(0-23)、日(1-31)、月(1-12)、曜日(0-7、0と7は日曜)を入力することができます。
括弧の中の数値が、指定できる数値の範囲となっています。

また、*/1のようにすると「1分間隔」のように間隔を指定することもできます。

## Let’s Encryptの証明書を自動で更新する場合

cretbotはインストール済みで、firewall等の設定は終わっているものとします。

下記の指定の場合、毎日午前3時にcertbotコマンドで更新をかけています。
また、更新を反映させるためhttpdサービスを再起動するように設定しています。

```
0 3 *  *  * root /usr/bin/certbot renew --post-hook \"systemctl restart httpd.service\"
```

## 手動で更新する場合

crontabでのスケジュールに関係なく証明書を更新したい場合は下記コマンドになります。

```
certbot renew
```

ただし、上記のコマンドの場合、証明書の有効期限の残りが30日未満の場合のみ更新されます。それ以上の期限が残っている場合は更新されません。

もし、有効期限までの残り日数に関係なく、すぐに証明書を更新したい場合は、` –force-renew` オプションを使います。

```
certbot renew --force-renew
```

      ",
      permalink: 'edit-crontab',
      status: 1,
      coedit_permit: 1,
      garbage: false
    },

    {
      user_id: 5,
      title: 'Vue.jsでアコーディオンを作る',
      content: "
Vue.jsでアコーディオンを作った際のメモです。

## コード

- テンプレートの`slot`を用いてコンテンツを挿入しています。
- Vue.jsのトランジションをJavascriptフックに適用して、アコーディオンの開閉時の高さを動かしています。

```html
<div class=\"container\">

  <div id=\"app\">

    <accordion>
      <div slot=\"title\" class=\"title\">アコーディオン1のタイトル</div>
      <section slot=\"content\" class=\"content\" >
        <h1>アコーディオン1のコンテンツ</h1>
        <p>アコーディオン1のコンテンツ</p>
      </section>
    </accordion>

    <accordion>
      <div slot=\"title\" class=\"title\">アコーディオン2のタイトル</div>
      <section slot=\"content\" class=\"content\">
        <h1>アコーディオン2のコンテンツ</h1>
        <p>アコーディオン2のコンテンツ</p>
      </section>
    </accordion>

    <accordion>
      <div slot=\"title\" class=\"title\">アコーディオン3のタイトル</div>
      <section slot=\"content\" class=\"content\">
        <h1>アコーディオン3のコンテンツ</h1>
        <p>アコーディオン3のコンテンツ</p>
      </section>
    </accordion>

  </div>

</div>
```


```css
.container {
  padding-top: 48px;
}
.accordion-title-wrapper {
  position: relative;
  display: block;
  cursor: pointer;
}
.title {
  padding: 16px;
  background: #f6f7f7;
}
h1 {
  font-size: 175%;
}
.accordion-title-wrapper .accordion-button-icon {
  position: absolute;
  top: 50%;
  transform: translateY(-50%) rotate(0deg);
  right: 16px;
  transition: 0.2s ease-in-out;
}
.accordion-content-wrapper {
  overflow: hidden;
  transition: 0.2s ease-in-out;
}
.accordion .content {
  padding: 16px;
}
.accordion .content :last-child {
  margin-bottom: 16px;
}
.accordion-title-wrapper.open .accordion-button-icon {
  transform: translateY(-50%) rotate(45deg);
}
```


```js
Vue.component('accordion', {
  template: `
    <div class=\"accordion\">
      <div class=\"accordion-title-wrapper\" v-on:click=\"toggle()\" v-bind:class=\"{ 'open': isOpen }\">

        <slot name=\"title\"></slot>

        <svg xmlns=\"http://www.w3.org/2000/svg\" class=\"accordion-button-icon icon icon-tabler icon-tabler-plus\" width=\"48\" height=\"48\" viewBox=\"0 0 24 24\" stroke-width=\"1\" stroke=\"#2c3e50\" fill=\"none\" stroke-linecap=\"round\" stroke-linejoin=\"round\">
          <path stroke=\"none\" d=\"M0 0h24v24H0z\" fill=\"none\"/>
          <line x1=\"12\" y1=\"5\" x2=\"12\" y2=\"19\" />
          <line x1=\"5\" y1=\"12\" x2=\"19\" y2=\"12\" />
        </svg>

      </div>

      <transition name=\"accordion\" v-on:before-enter=\"beforeEnter\" v-on:enter=\"enter\" v-on:before-leave=\"beforeLeave\" v-on:leave=\"leave\">

        <div class=\"accordion-content-wrapper\" v-if=\"isOpen\">
          <slot name=\"content\"></slot>
        </div>

      </transition>

    </div>
    `,

  data() {
    return {
      isOpen: false,
    };
  },
  methods: {
    toggle: function () {
      this.isOpen = !this.isOpen;
    },
    beforeEnter: function (el) {
      el.style.height = '0';
    },
    enter: function (el) {
      el.style.height = el.scrollHeight + 'px';
    },
    beforeLeave: function (el) {
      el.style.height = el.scrollHeight + 'px';
    },
    leave: function (el) {
      el.style.height = '0';
    }
  }
});

new Vue({
  el: '#app'
});
```

      ",
      permalink: 'vue-accordion',
      status: 1,
      coedit_permit: 0,
      garbage: false
    },

    {
      user_id: 6,
      title: 'ひとまず始めるTypescript',
      content: "

## 基本型 number、string、boolean

変数にデータ型を定義する場合は、変数宣言の際に`let 変数名: データ型 = 値;`と記述します。
これを**型注釈(Type Annotation)**と呼びます。
定数`const`の際も同じように`const 変数名: データ型 = 値;`と書きます。

基本のデータ型は真偽値、数値、文字列の3種類です。

```ts
// 真偽値を扱うboolean型
let flag: boolean = true;

// 数値を扱うnumber型
let value: number = 12;

// 文字列を扱うstring型
let word: string = \"abc\";
```

## 配列

配列の場合は`let 変数名: データ型[] = [値1, 値2, ...]`と宣言します。

```ts
// 文字列の配列の場合
let words: string[] = [\"a\", \"b\"];

// 数値の配列の場合
let luckyNumbers: number[] = [1033, 1046];
```

## any

`any`型を指定すると、どんなデータ型の値でも設定することができます。

```ts
let a: any = \"abc\";
```

便利な注釈方法ですが、Typescriptを使う意義が薄れてしまうためあまり乱用すべきではないでしょう。

## 型変換

当初に注釈したデータ型から異なる型に変換したい場合があります。その際は型変換を用います。

型変換には2種類の方法があります。

1. `<変換したいデータ型>変数名`
2. `変数名 as 変換したいデータ型`

```ts
// any型で変数hogeを定義
let hoge: any = \"1\";

// 1つ目の変換方法で、変数hogeをnumber型に変換して変数numAに格納
let numA: number = <number>hoge;

// 2つ目の変換方法で、変数hogeをnumber型に変換してnumBに格納
let numB: number = hoge as number;
```

2つの方法のどちらを使うかについては、例えばJSXでは1つ目の方法で書くことはできないなど、環境によって適切な方を選ぶ必要があります。

## 関数

関数には引数と戻り値にそれぞれデータ型を宣言できます。

```ts
function 関数名(引数: データ型): 戻り値のデータ型 {
  // 関数の処理
}
```

下記は、配列に格納された数値をすべてを合計する関数の例です。

```ts
// 配列に数値を格納する
let numberArray: number[] = [10, 20, 50];

// 引数に配列型を、戻り値にnumber型をそれぞれ型注釈する
function sum(arr: number[]): number {
  let sumValue: number = 0;
  for(let i = 0; i < arr.length; i++) {
    sumValue += arr[i];
  }
  return sumValue;
}

// 関数の実行
console.log(sum(numberArray));
// 80
```

アロー関数も同じように宣言できます。

```ts
// 配列に数値を格納する
let numberArray: number[] = [10, 20, 50];

// 引数に配列型を、戻り値にnumber型をそれぞれ型注釈する
const sum = (arr: number[]): number => {
  let sumValue: number = 0;
  for(let i = 0; i < arr.length; i++) {
    sumValue += arr[i];
  }
  return sumValue;
}

// 関数の実行
console.log(sum(numberArray));
// 80
```

戻り値がない関数の場合は、戻り値のデータ型に`void`を宣言することができます。

```ts
function 関数名(引数: データ型): void {
  // 関数の処理
}
```

## オブジェクト

以下のようなオブジェクトに型注釈を行う場合、変数の宣言とは方法を変える必要があります。

```ts
let animal = {
  id: 1,
  name: \"きりん\"
}
```

まずは、上記の`animal`オブジェクトを引数にして、idとnameをコンソールに出力する関数を例にしてみます。

```ts
// 関数の定義
function printName(animal: {id: number, name: string}) {
  console.log(animal.id);
  console.log(animal.name);
}

// 先ほどのオブジェクト
let animal = {
  id: 1,
  name: \"きりん\"
};

// 関数の実行
printName(animal);
// 1
// きりん
```

上記のコードでは、引数の定義部分で`animal`オブジェクトの型注釈を行なっています。
オブジェクトの規模によりますが、引数の定義部分にプロパティとデータ型をひとつずつ書いていくのはなかなか面倒ですし、何より可読性が悪くなってしまいます。
そこで*インターフェース*を利用してオブジェクトの型を定義してみます。

## インターフェース

インターフェースは、オブジェクトやクラスの構造自体の定義をするための機能です。インターフェースには、プロパティやメソッド、それぞれのデータ型を記述しますが、具体的な処理を持つことはできません。

なぜこのような機能があるかというと、インターフェースには、インターフェースをクラスやオブジェクトに適用(実装)する場合は、インターフェースに定義したプロパティやメソッドをすべて用意しないとエラーになるという特徴があるためです。インターフェースは構造を保証することで、クラスやオブジェクトをより安全に利用するための機能といえます。

インターフェースは下記のように記述します。インターフェース名は`UpperCamelケース`で命名します。

```ts
interface インターフェース名 {
  プロパティ名: データ型,
  プロパティ名: データ型,
  メソッド名(引数): データ型,
  メソッド名(引数): データ型,
  // ...
}
```

さきほどの`animal`オブジェクトをインターフェースで定義する場合下記のようになります。

```ts
interface AnimalInterface {
  id: number,
  name: string
}
```

では、インターフェースを利用したオブジェクトの型注釈を見てみます。

```ts
// インターフェースの定義
interface AnimalInterface {
  id: number,
  name: string
}

// 関数の定義
function printName(animal: AnimalInterface) {
  console.log(animal.id);
  console.log(animal.name);
}

// animalオブジェクト
let animal = {
  id: 1,
  name: \"きりん\"
};

// 関数の実行
printName(animal);
// 1
// きりん
```

インターフェースを定義し、関数の引数部分を`animal: AnimalInterface`と書くことで、オブジェクトをシンプルに利用できるようになりました。

オブジェクトの宣言時にインターフェースを適用する場合は、下記のようにオブジェクト名のあとに`: インターフェース名`を記述します。

```ts
let animal: AnimalInterface = {
  id: 1,
  name: \"きりん\"
};
```

      ",
      permalink: 'getting-started-with-typescript',
      status: 1,
      coedit_permit: 0,
      garbage: false
    }

  ]
)

# User.all.each_with_index do |user, n|
#   user.articles.create!(
#     user_id: user.id,
#     title: "タイトル#{n+1}",
#     content: "テキスト#{n + 1}",
#     status: 1,
#     coedit_permit: 0,
#     garbage: false
#   )
# end

# Tag.create!(
#   [
#     {
#       slug: "tag#{n+1}",
#       label: "タグその#{n + 1}",
#       edit_permit: 0,
#       user_id: n + 1
#     }
#   ]
# )

# 10.times do |n|
#   Tag.create!(
#     slug: "tag#{n+1}",
#     label: "タグその#{n + 1}",
#     edit_permit: 0,
#     user_id: n + 1
#   )
# end

# TagAssignment.create!(
#   [
#     {
#       article_id: 1,
#       tag_id: 1
#     },
#     {
#       article_id: 2,
#       tag_id: 2
#     },
#     {
#       article_id: 3,
#       tag_id: 3
#     },
#   ]
# )
