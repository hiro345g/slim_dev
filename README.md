# slim_dev

A development environment for PHP Slim framework program : PHPのSlimフレームワークを使ったプログラムを開発する環境を用意するときの雛形として利用するために、いくつかスクリプトなどを用意して、まとめたものです。

最初にSlim3のサンプルプログラムを動かしてみようと思って環境を用意しようとしたのですが、Slim4もリリースされているということに気がついたので、とりあえずのところは両方動かしてみようという方針にして、一通り揃えてみました。

最初にPHPの開発ではComposerを使うのが当たり前になってきているので、その用意をします。使っているOSでcomposerコマンドが実行できるようにするか、./composerか./composer_php73にあるスクリプトを使って ${HOME}/.local/bin/composer を用意します。これはdocker・docker-composeを利用して https://hub.docker.com/_/composer にある docker イメージを使います。docker・docker-compose は、あらかじめインストールしておく必要があります。

Slimアプリのチュートリアルで学ぶためには./slim3か./slim4にあるスクリプトを使います。./slim3はSlim3のチュートリアル http://www.slimframework.com/docs/v3/ のインストールに関する説明を参考にして用意しました。./slim4はSlim4のチュートリアル http://www.slimframework.com/docs/v4/ のインストールに関する説明を参考にして用意しました。

Slim3、Slim4はアプリの雛形をComposerで生成するプロジェクトが GitHub - slimphp/Slim-Skeleton: Slim Framework 4 Skeleton Application https://github.com/slimphp/Slim-Skeleton で開発されているので、ある程度 Slim について理解をしたら、こちらを使うのが良いようです。ということで、./slim3_skeletonと./slim4_skeletonも用意しました。生成されたアプリはdocker-composeで簡単に動作させることができます。

## 動作環境

下記の環境で動作確認をしています。

- Ubuntu 18.04
- docker version 19.03.5
- docker-compose version 1.23.1

## ファイル構成

下記のファイルが含まれます。

```
.
├── README.md ... このファイル
├── composer/ ... https://hub.docker.com/_/composer の docker イメージを利用するときに使います。
│   └── create_script.sh
├── composer_php73/ ... php:7.3-alpineの docker イメージで composer を利用するときに使います。
│   ├── build.sh
│   ├── create_script.sh
│   └── docker-compose.yml
├── slim3/ ... slim3 をとりあえず動かしたいときに使います。
│   ├── template/
│   │   ├── docker-compose.yml
│   │   └── index.php
│   └── tool/
│       ├── composer.sh
│       ├── setup.sh
│       ├── start.sh
│       └── stop.sh
├── slim3_skeleton/ ... slim3のスケルトンプロジェクトを生成したいときに使います。
│   └── tool/
│       └── composer.sh
├── slim4/ ... slim4 をとりあえず動かしたいときに使います。
│   ├── template/
│   │   ├── docker-compose.yml
│   │   └── index.php
│   └── tool/
│       ├── composer.sh
│       ├── setup.sh
│       ├── start.sh
│       └── stop.sh
└── slim4_skeleton/ ... slim4のスケルトンプロジェクトを生成したいときに使います。
    └── tool/
        ├── composer.sh
        └── init_composer.sh
```


## composer

dockerコマンドを使ってcomposer/composerのコンテナを実行すればcomposerコマンドと同じことは基本的にできるのですが、少し調べたところ、${HOME}/.local/bin/composer にスクリプトを生成すると便利そうなので、生成スクリプトを用意してみました。次のようにして利用できるようになります。user001アカウントを使っている例になります。

```
$ sh composer/create_script.sh
$ which composer
/home/user001/.local/bin/composer
$ composer --version
Current directory: '/home/user001/slim_dev'
Composer version 1.2.0 2016-07-19 01:28:52
```

## composer_php73

Slim4についてはPHP 7.0では動かないため、php:7-alpine をベースとしている https://hub.docker.com/_/composer の composer/composer は使えません。php:7.3-alpine をベースとする composer_php73:0.1 の docker イメージを作成することで解決します。そのための build.sh スクリプトを用意してあります。次のように実行します。

```
$ cd composer_php73
$ sh build.sh
```

こちらも、${HOME}/.local/bin/composer を生成するスクリプト create_script.sh を用意してみました。

```
$ sh composer_php73/create_script.sh
$ which composer
/home/user001/.local/bin/composer
$ composer --version
Current directory: '/home/user001/slim_dev'
Composer version 1.9.2 2020-01-14 16:30:31
```

## slim3

Slim 3 Documentation - Slim Framework http://www.slimframework.com/docs/v3/ にある内容を確認するために用意しました。Slim3 のパッケージをインストールするところまで確認しています。

このディレクトリーでは composer/composer の docker イメージでSlim3アプリ作成に必要なPHPパッケージを用意するために必要なスクリプトが含まれています。APP_NAMEでアプリ名を指定して使えるようにしてあります。下記を実行すると、./slim3/projects/sample/vendor に slim/slim3 のパッケージが用意されます。

```
$ cd slim3
$ APP_NAME=sample sh tool/composer.sh require slim/slim:"3.*"
```

これは、composerをインストールしてあるなら、次のコマンドを実行するのと同じです。

```
$ APP_NAME=sample
$ cd slim3
$ mkdir projects/${APP_NAME}
$ cd projects/${APP_NAME}
$ composer require slim/slim:"3.*"
```

これだけでは Slim3 のアプリを動作させるには足りないので、開発用の docker-compose.yml を含む Slim3 アプリ用の最低限の開発環境を簡単にセットアップするスクリプト ./slim3/tool/setup.sh を用意しました。

```
$ cd slim3
$ APP_NAME=sample sh tool/setup.sh
```

これで、./slim/projects/sample に環境が用意されます。docker コンテナを起動するには start.sh を使います。

```
$ cd slim3
$ APP_NAME=sample sh tool/start.sh
```

この後、Webブラウザで http://localhost:8080/hello/slim3 へアクセスして Hello slim3 と表示できたら成功です。表示される文字列を変更するには、./slim3/projects/sample/public/index.php を編集します。

docker コンテナ停止用のスクリプト stop.sh も用意してあります。

```
$ cd slim3
$ APP_NAME=sample sh tool/stop.sh
```

composer を使いたいときは ./slim3/tool/composer.sh を使います。setup.sh をした後で、次のように実行すると composer info slim/slim を実行したときと同じ結果になります。

```
$ cd slim3
$ APP_NAME=sample sh tool/composer.sh info slim/slim
```

## slim4

Slim 4 Documentation - Slim Framework http://www.slimframework.com/docs/v4/ にある内容を確認するために用意しました。Slim4 のパッケージをインストールするところまで確認しています。

ここでは./composer_php73にビルドした composer_php73:0.1 の docker イメージを使うので、あらかじめ用意しておく必要があります。

slim3 と基本的に同じ機能のスクリプトを用意してあります。APP_NAMEへアプリ名を指定して実行します。

開発用の docker-compose.yml を含む Slim4 アプリ用の最低限の開発環境を簡単にセットアップするには、スクリプト ./slim4/tool/setup.sh を使います。このスクリプトは内部的に ./slim4/tool/composer.sh を使っています。

```
$ cd slim4
$ APP_NAME=sample sh tool/setup.sh
```

これで、./slim4/projects/sample に環境が用意されます。docker コンテナを起動するには start.sh を使います。

```
$ cd slim4
$ APP_NAME=sample sh tool/start.sh
```

この後、Webブラウザで http://localhost:8080/ へアクセスして Hello world! と表示できたら成功です。表示される文字列を変更するには、./slim4/projects/sample/public/index.php を編集します。

停止には stop.sh を使います。

```
$ cd slim4
$ APP_NAME=sample sh tool/stop.sh
```

composer を使いたいときは ./slim4/tool/composer.sh を使います。setup.sh をした後で、次のように実行すると composer info slim/slim を実行したときと同じ結果になります。

```
$ cd slim4
$ APP_NAME=sample sh tool/composer.sh info slim/slim
```

## Slim-Skeleton

GitHub - slimphp/Slim-Skeleton: Slim Framework 4 Skeleton Application https://github.com/slimphp/Slim-Skeleton で開発されているスケルトンを簡単に使ってみるためのスクリプトを用意してあります。

### Slim-Skeleton 3

./slim3_skeleton で Slim 3 のスケルトンを使ってアプリを用意するには次のようにします。composerコマンドが使えるなら `sh tool/composer.sh` は `composer` へ置き換えてもよいです。

```
$ cd slim3_skeleton
$ APP_NAME=sample
$ sh tool/composer.sh create-project "slim/slim-skeleton=3.1.8" ${APP_NAME}
$ cd projects/${APP_NAME}
$ docker-compose up -d
```

これで、Webブラウザを使って http://localhost:8080/ にアクセスすると Slim の画面が表示されます。停止は `docker-compose down` を実行します。

```
$ cd slim3_skeleton/projects/sample
$ docker-compose down
```

なお、テストは次のようにして実行することができます。

```
$ cd slim4_skeleton/projects/sample
$ APP_NAME=sample sh ../../tool/composer.sh test
```

### Slim-Skeleton 4

./slim4_skeleton には Slim 4 を使うときのためのスクリプトがあります。スケルトンから生成されるアプリ用の docker-compose.yml では php:7-alpine が指定されています。composer_php73:0.1 に合わせて、PHP7.3 で実行する方が良いはずなので php:7.3-alpine へ置換しています。

```
$ cd slim4_skeleton
$ APP_NAME=sample
$ sh tool/init_composer.sh create-project slim/slim-skeleton ${APP_NAME}
$ cd projects/${APP_NAME}
$ sed -i 's/7-alpine/7.3-alpine/' docker-compose.yml
$ docker-compose up -d
```

Webブラウザで http://localhost:8080/ にアクセスすると Slim の画面が表示されます。Hello world! は、./slim4/projects/sample/app/routes.php で指定されているので、これを変更すると表示文字が変わります。停止は `docker-compose down` を実行します。

```
$ cd slim4_skeleton/projects/sample
$ docker-compose down
```

なお、テストは次のようにして実行することができます。

```
$ cd slim4_skeleton/projects/sample
$ APP_NAME=sample sh ../../tool/composer.sh test
```
