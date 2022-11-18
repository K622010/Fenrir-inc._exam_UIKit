//
//  SearchResultView.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/06.
//

import UIKit
import CoreLocation
import MapKit


// MARK: - 検索結果のお店を一覧で表示する
class SearchResultViewController: UIViewController, MyDelegate {
    
    // お店一覧を表示するスクロールビュー
    @IBOutlet weak var restaurantListScrollView: UIScrollView!
    
    // 一覧表示されたお店一件のView
    @IBOutlet weak var RestaurantListView: UIStackView!
    
    // 戻るボタン
    @IBOutlet weak var dismissButton: UIImageView!
    
    var shops: [Shop] = []
        
    // デコーダー
    let decoder: JSONDecoder = JSONDecoder()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面全体の設定
        setupView()
        
        // お店の情報を一覧で表示
        addRestaurantView()
        
        // 戻るボタンを押した際の処理
        setupTapAction()
    }
    
    // 画面全体の設定
    func setupView() {
        
        // RestaurantViewとrestaurantListScrollViewの横幅を合わせる
        restaurantListScrollView.contentSize = RestaurantListView.frame.size
        
        // 一瞬だけスクロールバーを出して、ユーザーにスクロールできることを伝える
        restaurantListScrollView.flashScrollIndicators()
        
        // ナビゲーションバーを非表示化
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // お店の情報を一覧で表示
    func addRestaurantView() {
        
        // 検索結果の数だけSearchResultViewを表示
        for shop in shops {
            setupSearchResultView(shop: shop)
        }
        
        // 高さ100のスペースを設置
        let paddingView = UIView()
        paddingView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        RestaurantListView.addArrangedSubview(paddingView)
    }
    
    // 検索結果の数だけSearchResultViewを表示
    func setupSearchResultView(shop: Shop) {
        
        // お店の情報を表示するViewを定義
        let newView = RestaurantView()
        
        // 高さを100までに制限
        newView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        // AutoLayoutで構築しないように設定
        newView.translatesAutoresizingMaskIntoConstraints = false
        
        // 料理画像を表示するViewを定義
        newView.thumbnail.image = UIImage(url: shop.photo.pc.l!)
        
        // 名前を格納
        newView.name.text = shop.name
        
        // アクセスを格納
        newView.place.text = shop.access
        
        // お店の情報を格納
        newView.shop = shop
        
        // 親ViewをSearchResultViewControllerと定義
        newView.parentView = self
        
        // スクロールビューに追加
        RestaurantListView.addArrangedSubview(newView)
        
        // 空白を定義
        let paddingView = UIView()
        
        // 高さを5に設定
        paddingView.frame = CGRect(x: 0, y: 0, width: RestaurantListView.frame.width, height: 0)
        paddingView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        RestaurantListView.addArrangedSubview(paddingView)
        
    }
    
    // DetailViewControllerに画面遷移
    func transitionDetailViewController(shop: Shop) {
        
        // 読み込むStoryboardを設定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 遷移先の情報を格納
        let nextPage: DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        // 遷移先のViewにお店の情報を格納
        nextPage.shop = shop
        
        // 画面遷移をUINavigationControllerで行う
        let nextPageNavigationController = UINavigationController(rootViewController: nextPage)
        
        // フルスクリーン表示
        nextPageNavigationController.modalPresentationStyle = .fullScreen
        
        // 画面遷移の実行
        present(nextPageNavigationController, animated: true, completion: nil)
    }
    
    // 戻るボタンを押した際の処理
    private func setupTapAction() {
        
        // タップを有効化
        self.dismissButton.isUserInteractionEnabled = true
        
        // タップ時にdismissSearchResultView()を実行
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissSearchResultView))
        
        // ボタンにアクションを連携
        dismissButton.addGestureRecognizer(tapGestureRecognizer)
        
        // ナビゲーションバーを非表示化
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // 前の画面に遷移
    @objc private func dismissSearchResultView() {
        self.dismiss(animated: true)
    }
}


// MARK: - 一覧表示されたお店一件のView
class RestaurantView: UIView {
    
    // 料理画像
    let thumbnail = UIImageView(image: UIImage(named: "sample1"))
    
    // マップに表示するピン
    let mapPin = UIImageView(image: UIImage(named: "mapPin"))
    
    // お店の名前
    let name = UILabel()
    
    // アクセス情報
    let place = UILabel()
    
    // デリゲートの設定
    var delegate: MyDelegate?
    
    var shop: Shop? = nil
    
    // 親Viewを定義
    var parentView: SearchResultViewController? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        
        // 画面遷移を行う処理
        setupTapAction()
        
        // RestaurantViewの画面設定
        distributeCardView()
    }
    
    // 画面遷移を行う処理
    func setupTapAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(delegateTransitionDetailViewController))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // RestaurantViewの画面設定
    func distributeCardView() {
        
        // フォントの種類・大きさを定義
        name.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        place.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        
        // 文字色を設定
        name.textColor = UIColor.black
        place.textColor = UIColor.gray
        
        // 無制限に改行を許可
        place.numberOfLines = 0
        
        // 文字単位で折り返す
        place.lineBreakMode = .byCharWrapping
        
        // 画面レイアウト
        thumbnail.frame = CGRect(x: 20, y: 15, width: 70, height: 70)
        mapPin.frame = CGRect(x: 100, y: 56, width: 18, height: 18)
        name.frame = CGRect(x: 110, y: 20, width: 230, height: 30)
        place.frame = CGRect(x: 120, y: 50, width: 230, height: 30)
        
        // それぞれのパーツをRestaurantViewに追加
        self.addSubview(name)
        self.addSubview(place)
        self.addSubview(mapPin)
        self.addSubview(thumbnail)
        
        // 背景を白色にする
        self.backgroundColor = UIColor.white
        
        // RestaurantViewを角丸にする
        self.layer.cornerRadius = 20
        
        // 影の設定
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 2
    }
    
    // 親Viewにある画面遷移関数を実行
    @objc private func delegateTransitionDetailViewController() {
        
        // 親Viewをデリゲート
        self.delegate = parentView
        
        // 画面遷移関数を実行
        delegate?.transitionDetailViewController(shop: shop!)
    }
}

// 画面遷移関数を定義
protocol MyDelegate: AnyObject {
    func transitionDetailViewController(shop: Shop)
}




