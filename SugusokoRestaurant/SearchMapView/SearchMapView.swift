//
//  SearchMapView.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/05.
//
//
//import UIKit
//import MapKit
//
//class ViewController: UIViewController, MKMapViewDelegate {
//
//
//
//    // 経度緯度.
//
//    let myLan: CLLocationDegrees = 37.331741
//
//    let myLon: CLLocationDegrees = -122.030333
//
//
//
//    var center: CLLocationCoordinate2D!
//
//
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//
//
//        // 地図の中心の座標.
//
//        center = CLLocationCoordinate2DMake(myLan, myLon)
//
//
//
//        // mapViewを生成.
//
//        var myMapView: MKMapView = MKMapView()
//
//        myMapView.frame = self.view.frame
//
//        myMapView.center = self.view.center
//
//        myMapView.centerCoordinate = center
//
//        myMapView.delegate = self
//
//
//
//        // 縮尺を設定.
//
//        let mySpan: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//
//        let myRegion: MKCoordinateRegion = MKCoordinateRegion(center: center, span: mySpan)
//
//
//
//        // regionをmapViewに追加.
//
//        myMapView.region = myRegion
//
//
//
//        // viewにmapViewを追加.
//
//        self.view.addSubview(myMapView)
//
//
//
//        // 円を描画する(半径1000m).
//
//        let myCircle: MKCircle = MKCircle(centerCoordinate: center, radius: CLLocationDistance(1000))
//
//
//
//        // mapViewにcircleを追加.
//
//        myMapView.addOverlay(myCircle)
//
//    }
//
//
//
//    override func didReceiveMemoryWarning() {
//
//        super.didReceiveMemoryWarning()
//
//    }
//
//
//
//    /*
//
//    addOverlayした際に呼ばれるデリゲートメソッド.
//
//    */
//
//    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
//
//
//
//        // rendererを生成.
//
//        let myCircleView: MKCircleRenderer = MKCircleRenderer(overlay: overlay)
//
//
//
//        // 円の内部を赤色で塗りつぶす.
//
//        myCircleView.fillColor = UIColor.redColor()
//
//
//
//        // 円周の線の色を黒色に設定.
//
//        myCircleView.strokeColor = UIColor.blackColor()
//
//
//
//        // 円を透過させる.
//
//        myCircleView.alpha = 0.5
//
//
//
//        // 円周の線の太さ.
//
//        myCircleView.lineWidth = 1.5
//
//
//
//        return myCircleView
//
//    }
//
//
//
//}


