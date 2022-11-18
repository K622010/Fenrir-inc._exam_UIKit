//
//  InputSearchInformationView.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/05.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire


// MARK: - 現在地周辺のお店を検索する
class InputSearchInformationViewController: UIViewController {

    // 現在地付近の地図を表示
    @IBOutlet weak var myMapView: MKMapView!
    
    // 探すお店の半径を指定するView
    @IBOutlet weak var scalePickerView: UIPickerView!
    
    // 地図の中心
    var center: CLLocationCoordinate2D!
    
    // 検索する半径
    var searchScale: [CLLocationDistance] = [300, 500, 1000, 2000, 3000]
    
    // 検索半径の初期値に1000mを選択(searchScaleの3番目)
    var selectedSearchScaleNumber: Int = 2
    
    // 緯度
    var latitudeNow: CLLocationDegrees = 34.6
    // 経度
    var longitudeNow: CLLocationDegrees = 1.7

    // ロケーションマネージャ
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ロケーションマネージャのセットアップ
        setupLocationManager()

        // マップのセットアップ
        setupMapView()
        
        // ピッカービューのセットアップ
        setupPickerView()
    }

    
    @IBAction func search(_ sender: Any) {
        
        // 検索条件をSearchOptionクラスに格納
        let searchOption = SearchOption(latitudenow: latitudeNow, longtitudeNow: longitudeNow, range: selectedSearchScaleNumber+1)
       
        // デコーダー
        let decoder: JSONDecoder = JSONDecoder()
        
        // ホットペッパーAPIへリクエストを送信
        AF.request(searchOption.returnRequestWords()).responseJSON { response in
            switch response.result {
                
            // 送信に成功した場合
            case .success:
                do {
                    // 受信結果を格納
                    let articles = try decoder.decode(Welcome.self, from: response.data!)
                    
                    // SearchResultViewへ画面遷移
                    transitionSearchResultViewController(articles: articles)
                } catch {
                    print("デコードに失敗しました")
                }
                
            // 送信に失敗した場合
            case .failure(let error):
                print("error", error)
            }
        }
        
        // SearchResultViewへ画面遷移
        func transitionSearchResultViewController(articles: Welcome) {
            
            // 読み込むStoryboardを設定
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // 遷移先の情報を格納
            let nextPage: SearchResultViewController = storyboard.instantiateViewController(withIdentifier: "SearchResultViewController") as! SearchResultViewController
            
            // 遷移先のViewにお店の情報を格納
            nextPage.shops = articles.results.shop
            
            // 画面遷移をUINavigationControllerで行う
            let nextPageNavigationController = UINavigationController(rootViewController: nextPage)
            
            // フルスクリーン表示
            nextPageNavigationController.modalPresentationStyle = .fullScreen
            
            // 画面遷移の実行
            present(nextPageNavigationController, animated: true, completion: nil)
        }
    }

    // ロケーションマネージャのセットアップ
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self

        // 権限をリクエスト
        locationManager!.requestWhenInUseAuthorization()

        // マネージャの設定
        let status = CLLocationManager().authorizationStatus

        // ステータスごとの処理
        if status == .authorizedWhenInUse {
            locationManager!.delegate = self
            locationManager!.startUpdatingLocation()
        }
    }

    // アラートを表示する
    func showAlert() {
        let alertTitle = "位置情報取得が許可されていません。"
        let alertMessage = "設定アプリの「プライバシー > 位置情報サービス」から変更してください。"
        let alert: UIAlertController = UIAlertController(
            title: alertTitle,
            message: alertMessage,
            preferredStyle:  UIAlertController.Style.alert
        )
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        // UIAlertController に Action を追加
        alert.addAction(defaultAction)
        
        // Alertを表示
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - 現在地周辺の地図を生成
extension InputSearchInformationViewController: MKMapViewDelegate {
    // mapViewを生成
    func setupMapView() {
        // 地図の中心の座標
        center = CLLocationCoordinate2DMake(latitudeNow, longitudeNow)
        myMapView.centerCoordinate = center
        myMapView.delegate = self
        myMapView.layer.cornerRadius = myMapView.frame.size.width * 0.5

        // 縮尺を設定.
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)

        // regionをmapViewに追加
        myMapView.region = myRegion

        // viewにmapViewを追加
        self.view.addSubview(myMapView)
    }

    // メモリでの警告が出されたときにメモリを解放する
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


// MARK: - 検索する半径を設定
extension InputSearchInformationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // 初期設定
    func setupPickerView() {
        scalePickerView.dataSource = self
        scalePickerView.delegate = self
        scalePickerView.setValue(UIColor.black, forKeyPath: "textColor")
        
        // 初期値は1000m
        scalePickerView.selectRow(2, inComponent: 0, animated: false)
    }
    
    // 一行に１つ表示
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 一列にデータの個数分表示
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return searchScale.count
    }
    
    // 選択する要素を表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == scalePickerView {
            return String(Int(searchScale[row]))+"m"
        }
        return nil
    }
    
    // 選択された要素の順番を格納
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSearchScaleNumber = row
    }
    
}


// MARK: - 位置情報の更新
extension InputSearchInformationViewController: CLLocationManagerDelegate {

    // 位置情報が更新された際、位置情報を格納する
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        
        let myLocations: NSArray = locations as NSArray
        let myLastLocation: CLLocation = myLocations.lastObject as! CLLocation
        let myLocation:CLLocationCoordinate2D = myLastLocation.coordinate

        // 位置情報を格納する
        self.latitudeNow = latitude!
        self.longitudeNow = longitude!
        
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, latitudinalMeters: searchScale[selectedSearchScaleNumber], longitudinalMeters: searchScale[selectedSearchScaleNumber])
        myMapView.setRegion(myRegion, animated: true)
    }
    
    
}
