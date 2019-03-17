# PasswordGenerator
【PowerShell】パスワードを生成するPowerShell製のGUIプログラム

### 概要
PowerShellのGUIプログラミングを習得するために、パスワード生成に関して思いつく限りの機能を詰め込んで作ってみたアプリです。<br>
パスワードを複数生成する機能もあり、生成したパスワードはプレーンテキスト以外にも、CSV、XML、JSONのほか、RTFやXPSとか無駄に様々なフォーマットでファイル出力できます。

### 動作要件

* Windows OS<br>
* PowerShell 3.0以降 (2.0でも一応動きますが、若干の不具合や制限があります)<br>

### インストール
`PasswordGenerator.ps1`を適当な場所に配置してください。

### 実行方法
PowerShellスクリプト(.ps1)の実行方法については割愛します。<br>
実行するとPasswordGeneratorウインドウが立ち上がります。<br>
使い方はシンプルで、なるべく直感的な作りにしてありますので、大体の使用方法はわかると思います。<br>

### 機能

* 英字小文字、英字大文字、数字、記号、スペースの各文字種を組み合わせてランダムなパスワードを生成します。<br>
* 使いたい文字種は選択することが出来、それぞれの文字種の中で利用する文字を編集することが出来ます。<br>
* 生成したパスワードの読み仮名を表示することが出来ます。<br>
* パスワードをただ単にランダム生成するのではなく、それぞれの文字種を必ず一文字以上含めて生成したり、スペース以外の各文字種を均等に利用して生成することが出来ます。
* 生成出来るパスワードの桁数は1024桁まで対応しています。(あまり現実的ではありませんが)
* パスワードの桁数を変動にし、ランダムな文字数でパスワードを生成出来ます。
* パスワードを生成後、クリップボードにパスワードをコピーする機能を用意しています。
* 生成したパスワードで、それぞれの文字種の出現数を表示できます。(簡易生成機能のみ)<br>
* 複数のパスワードを一括で生成する機能を搭載しています。(上限9999個まで)
* 変更した設定は`設定保存`ボタンで設定を保存出来ます。<br>設定情報は`PasswordGenerator.ps1`と同じディレクトリにXML形式のファイルに保存され、レジストリ等を使用することはありません。
* 複数パスワード生成画面では、生成したパスワードと読み仮名を以下のフォーマットで出力出来ます。
    * CSV (UTF-8 BOM付)(*.csv)
    * CSV (UTF-8 BOM無)(*.csv)
    * XMLデータ(*.xml)
    * JSONデータ(*.json)
    * Webページ(*.html)
    * リッチテキスト(*.rtf)
    * XPSドキュメント(*.xps)    ※PowerShell2.0では出力出来ません。
    * プレーンテキスト(*.txt)    ※読み仮名は出力されません。
