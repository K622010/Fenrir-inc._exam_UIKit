//
//  HotpepperFetchable.swift
//  SugusokoRestaurant
//
//  Created by 江越瑠一 on 2022/11/05.
//


import Foundation
import Combine
import CoreLocation

protocol HotpepperFetchable {
    func fetchGourmet(coordinate: CLLocationCoordinate2D) -> AnyPublisher<HotPepperResponse, HotpepperError>
    func fetchShop(query: String) -> AnyPublisher<HotPepperResponse, HotpepperError>
}

