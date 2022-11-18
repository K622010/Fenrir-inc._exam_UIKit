//
//  Utils.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/18.
//

import Foundation
import UIKit

// MARK: - URLから画像を読み込む
extension UIImage {
    
    public convenience init(url: String) {
        let url = URL(string: url)
        
        // URLから画像の読み込みに成功した場合、画像データをdataに格納
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            
            // 失敗した場合はエラーメッセージを表示
            print("Error : \(err.localizedDescription)")
        }
        
        self.init()
    }
}
