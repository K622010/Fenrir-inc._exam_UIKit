# SugusokoRestaurant

![sugusoko](https://user-images.githubusercontent.com/117096416/202648905-eee04f96-1752-4610-aa14-53bf0bb039b3.gif)

### 作者
江越瑠一

### アプリ名
SugusokoRestaurant

### 動作対象OS
iOS 16.1.1

### 開発環境
Xcode 14.1

### 開発言語
Swift 5.7.1

### 開発期間
14日間

### 機能概要
- 周辺の飲食店を検索：ホットペッパーグルメサーチAPIを使用して、現在地周辺の飲食店を検索する。
- 飲食店の詳細情報を取得：ホットペッパーグルメサーチAPIを使用して、飲食店の詳細情報を取得する。

### 画面概要
- 検索画面 ：条件を指定してレストランを検索する。
- 一覧画面 ：検索結果の飲食店を一覧表示する。
- 詳細画面 ：選択した飲食店の情報や位置を詳細に表示する。

### 使用しているAPI,SDK,ライブラリなど
- ホットペッパーグルメサーチAPI
- Mapkit
- CoreLocation
- Alamofire

### コンセプト
拡縮マップによって、探したい範囲のお店が見つかる。

### こだわったポイント
- 貴社の夏季インターンシップで「storyboardを使用した開発」を教えていただいたため、可能な範囲でstoryboardを用いてレイアウトを行った。
- 画面表示時（viewDidLoad実行時）に行われる処理が多かったため、コードの可読性を意識して「setup〇〇」といった名前で処理を分割した。

### デザイン面でこだわったポイント
- 一覧画面を始めとした多くの画面で用いる色は必要最低限とし、料理写真が映えるように構成した。
- デザイン性が優れている多くのアプリを参考に、スタイリッシュに見えるようなViewの形、シャドウにこだわって一覧画面を制作した。

### アドバイスして欲しいポイント
一覧画面や詳細画面でお店の情報を扱う機会が多いが、このコードでは遷移先にお店の情報を全て渡していて、処理の効率が悪いと考えている。
そのため、グローバル変数として宣言するなど、処理を少なくするための方法を教えて欲しい。

### 不具合
- 検索結果が6件を超えると、一覧画面で表示しきれなくなる。


### プロジェクト構成
    SugusokoRestaurant
      ├── API
      │    ├── API.swift
      │    └── SearchOption.swift
      ├── Main
      │    ├── Base.lproj
      │    │    └── Main.storyboard
      │    ├── AppDelegate.swift
      │    └── SceneDelegate.swift
      ├── SugusokoRestaurant.xcdatamodeld
      ├── Utils
      │    ├── Assets.xcassets
      │    ├── Info.plist
      │    └── Utils.swift
      └── ViewParts
           ├── DetailViewController.swift
           ├── InputSearchInformationView.swift
           └── SearchResultViewController.swift
