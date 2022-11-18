# SugusokoRestaurant

![sugusoko](https://user-images.githubusercontent.com/117096416/202648905-eee04f96-1752-4610-aa14-53bf0bb039b3.gif)

### 簡易仕様書
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
    - レストラン検索：ホットペッパーグルメサーチAPIを使用して、現在地周辺の飲食店を検索する。
    - レストラン情報取得：ホットペッパーグルメサーチAPIを使用して、飲食店の詳細情報を取得する。
    - お気に入り登録：検索結果の中からお気に入りのお店を登録することで、アプリを再起動した後でもトップ画面からお店の情報を見ることができる。

    ### 画面概要
    - 検索画面 ：条件を指定してレストランを検索する。
    - 一覧画面 ：検索結果の飲食店を一覧表示する。
    - 詳細画面 ：選択した飲食店の情報や位置を詳細に表示する。

    ### 使用しているAPI,SDK,ライブラリなど
    - ホットペッパーグルメサーチAPI
    - CoreData
    - Mapkit
    - CoreLocation
    - Alamofire

    ### コンセプト
    あなたにとってお気に入りのお店が近くできっと見つかる。

    ### こだわったポイント
    CoreDataを使用して、気に入ったお店をiPhone本体に保存できるようにした。

    ### デザイン面でこだわったポイント
    一覧画面では料理画像を背景にViewを作り、文字サイズも見やすい範囲でなるべく小さくした。
    これは、ユーザーが料理写真を見て「美味しそう」と感じやすくなる効果を狙っている。

    ### アドバイスして欲しいポイント
    チームメンバーに伝わりやすいような命名規則をアドバイスして欲しい。
    私にとっては見ただけで大体何がしたいのか分かる命名になっているが、チーム開発を行っているエンジニア視点で分かりづらい箇所があれば教えてほしい。

    ### 不具合
    - HomeView（検索画面）で地図を触ると、位置情報の更新と地図の再描画が高頻度で繰り返され、アプリが重くなってしまう。
      Viewを更新する際に@State属性を持つ変数を変更しないようにすれば治るが、位置情報をリアルタイムで反映できなくなる。
    - 飲食店のお気に入り情報が一覧画面に反映できておらず、同じお店を何回でもお気に入り登録できてしまう
      ホットペッパーAPIからお店IDを抽出し、お気に入り登録した飲食店と一致するかを比較すれば治ると考えている
    - 「yosugara」フォントに対応していない漢字が出てくると、対応していない部分だけデフォルトのフォントで表示される

    ### 該当プロジェクトのリポジトリ URL（GitHub,GitLab など Git ホスティングサービスを利用されている場合）
    https://github.com/xxxx

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
