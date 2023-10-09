//
//  HotelMainInfoCollectionViewCellViewModel.swift
//  hotel
//
//  Created by Admin on 08.09.2023.
//

import Foundation

final class HotelMainInfoCollectionViewCellViewModel {
    public var hotelName: String
    public var hotelAddress: String
    public var minimalPrice: String 
    public var priceOption: String
    public var rating: String
    
    init(hotelName: String, hotelAddress: String, minimalPrice: String, priceOption: String, rating: String) {
        self.hotelName = hotelName
        self.hotelAddress = hotelAddress
        self.minimalPrice = minimalPrice
        self.priceOption = priceOption
        self.rating = rating
    }
    
}
