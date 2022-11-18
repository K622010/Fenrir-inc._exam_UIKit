//
//  DetailView.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/12.
//

import Foundation
import UIKit
import MapKit


// MARK: - 検索結果の詳細な情報を表示
class DetailViewController: UIViewController {
    
    // 料理写真
    @IBOutlet weak var foodView: UIImageView!
    
    // お店の位置が表示されるマップ
    @IBOutlet weak var restaurantMapView: MKMapView!
    
    // 画面上部に表示される名前
    @IBOutlet weak var nameTop: UILabel!
    
    // 画面中央部に表示される名前
    @IBOutlet weak var nameMid: UILabel!
    
    // アクセス情報
    @IBOutlet weak var place: UILabel!
    
    // 営業時間
    @IBOutlet weak var time: UILabel!
    
    // 戻るボタン
    @IBOutlet weak var dismissButton: UIImageView!
    
    var shop: Shop? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // お店の情報をViewに入力
        setupView()
        
        // ピンが刺されたマップを作成
        setupMapPin()
        
        // 戻るボタンを押した後の処理
        setupTapAction()
    }
    
    // お店の情報をViewに入力
    private func setupView() {
        self.foodView.image = UIImage(url: shop!.photo.pc.l!)
        self.nameTop.text = shop!.name
        self.nameMid.text = shop!.name
        self.place.text = shop!.access
        self.time.text = shop!.shopOpen
    }
    
    // ピンが刺されたマップを作成
    private func setupMapPin() {
        
        // お店の位置情報を格納
        let coordinate = CLLocationCoordinate2DMake(shop!.lat!, shop!.lng!)
        
        // ピンを作成
        let pin = MKPointAnnotation()
        
        // お店の名前をピンに表示
        pin.title = shop!.name
        
        // ピンをタップしたときにアクセス情報を表示
        pin.subtitle = shop!.access
        
        // ピンの位置を定義
        pin.coordinate = coordinate
        
        // マップを初期化
        var region = restaurantMapView.region
        
        // お店を中央に表示
        region.center = coordinate
        
        // 緯度・経度の縮尺を設定
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        // マップを作成
        restaurantMapView.setRegion(region, animated: true)
        
        // ピンを刺す
        restaurantMapView.addAnnotation(pin)
    }
    
    // 戻るボタンを押した後の処理
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

