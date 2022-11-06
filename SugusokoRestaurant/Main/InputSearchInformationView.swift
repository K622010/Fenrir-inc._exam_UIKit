//
//  InputSearchInformationView.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/05.
//

import UIKit
import CoreLocation
import MapKit

class InputSearchInformationViewController: UIViewController, MKMapViewDelegate {

    /// 緯度を表示するラベル
    @IBOutlet weak var latitude: UILabel!
    /// 経度を表示するラベル
    @IBOutlet weak var longitude: UILabel!

    @IBOutlet weak var searchMapView: MKMapView!
    // 緯度
    var latitudeNow: CLLocationDegrees = 37
    // 経度
    var longitudeNow: CLLocationDegrees = 18

    /// ロケーションマネージャ
    var locationManager: CLLocationManager?

    override func viewDidLoad() {
        super.viewDidLoad()

        // ロケーションマネージャのセットアップ
        setupLocationManager()
        
        // マップのセットアップ
        setupMapView(myMapView: searchMapView)
    }

    /// "位置情報を取得"ボタンを押下した際、位置情報をラベルに反映する
    /// - Parameter sender: "位置情報を取得"ボタン
    @IBAction func getLocationInfo(_ sender: Any) {
        // マネージャの設定
        let status = CLLocationManager().authorizationStatus
        if status == .denied {
            showAlert()
        } else if status == .authorizedWhenInUse {
            self.latitude.text = String(latitudeNow)
            self.longitude.text = String(longitudeNow)
        }
    }

    /// "クリア"ボタンを押下した際、ラベルを初期化する
    /// - Parameter sender: "クリア"ボタン
    @IBAction func clearLabel(_ sender: Any) {
        self.latitude.text = "デフォルト"
        self.longitude.text = "デフォルト"
    }


    /// ロケーションマネージャのセットアップ
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self

        // 権限をリクエスト
//        guard let locationManager = locationManager else { return }
        locationManager!.requestWhenInUseAuthorization()

        // マネージャの設定
        let status = CLLocationManager().authorizationStatus

        // ステータスごとの処理
        if status == .authorizedWhenInUse {
            locationManager!.delegate = self
            locationManager!.startUpdatingLocation()
        }
    }

    /// アラートを表示する
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
    
    // mapViewを生成
    func setupMapView(myMapView: MKMapView) {
        // 地図の中心の座標
        let center: CLLocationCoordinate2D! = CLLocationCoordinate2DMake(latitudeNow, longitudeNow)
        
//        myMapView.frame = self.view.frame
//        myMapView.center = self.view.center
        myMapView.centerCoordinate = center
        myMapView.delegate = self

        // 縮尺を設定.
        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: myMapView.userLocation.coordinate, span: mySpan)
        
        // regionをmapViewに追加.
        myMapView.region = myRegion

        // viewにmapViewを追加.
        self.view.addSubview(myMapView)

        // 円を描画する(半径100m).
        let myCircle: MKCircle = MKCircle(center: center, radius: CLLocationDistance(100))
        
        // mapViewにcircleを追加.
        myMapView.addOverlay(myCircle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    /*
    addOverlayした際に呼ばれるデリゲートメソッド
    */

    internal func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // rendererを生成.
        let myCircleView: MKCircleRenderer = MKCircleRenderer(overlay: overlay)

        // 円の内部を赤色で塗りつぶす.
        myCircleView.fillColor = UIColor.red

        // 円周の線の色を黒色に設定.
        myCircleView.strokeColor = UIColor.black

        // 円を透過させる.
        myCircleView.alpha = 0.5

        // 円周の線の太さ.
        myCircleView.lineWidth = 1.5

        return myCircleView
    }
}

extension InputSearchInformationViewController: CLLocationManagerDelegate {

    /// 位置情報が更新された際、位置情報を格納する
    /// - Parameters:
    ///   - manager: ロケーションマネージャ
    ///   - locations: 位置情報
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        let latitude = location?.coordinate.latitude
        let longitude = location?.coordinate.longitude
        // 位置情報を格納する
        self.latitudeNow = latitude!
        self.longitudeNow = longitude!
    }
}
