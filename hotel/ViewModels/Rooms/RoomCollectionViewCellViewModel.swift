//
//  RoomCollectionViewCellViewModel.swift
//  hotel
//
//  Created by Admin on 25.09.2023.
//

import Foundation

final class RoomCollectionViewCellViewModel {
    public var titleName: String
    public var price: String
    public var pricePer: String
    public var peculiarities: [String]
    public var imageUrls: [String]
    
    init(titleName: String, price: String, pricePer: String, peculiarities: [String], imageUrls: [String]) {
        self.titleName = titleName
        self.price = price
        self.pricePer = pricePer
        self.peculiarities = peculiarities
        self.imageUrls = imageUrls
    }
}
