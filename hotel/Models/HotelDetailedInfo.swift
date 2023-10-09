//
//  HotelDetailedInfo.swift
//  hotel
//
//  Created by Admin on 06.09.2023.
//

import Foundation

struct HotelDetailedInfo: Codable {
    
    struct HotelDescription: Codable {
        var description: String
        var peculiarities: [String]
    }
    
    var id: Int
    var name: String
    var adress: String
    var minimalPrice: Int
    var priceOption: String
    var rating: Int
    var ratingName: String
    var imageUrls: [String]
    var aboutHotel: HotelDescription
    
    enum CodingKeys: String, CodingKey {
        case id, name, adress, rating
        case minimalPrice = "minimal_price"
        case priceOption = "price_for_it"

        case ratingName = "rating_name"
        case imageUrls = "image_urls"
        case aboutHotel = "about_the_hotel"
    }
}
