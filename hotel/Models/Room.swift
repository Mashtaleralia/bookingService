//
//  Room.swift
//  hotel
//
//  Created by Admin on 24.09.2023.
//

import Foundation

struct Rooms: Codable {
    var rooms: [Room]
}

struct Room: Codable {
    
    var id: Int
    var name: String
    var price: Int
    var tourLength: String
    var peculiarities: [String]
    var imageUrls: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, peculiarities
        case tourLength = "price_per"
        case imageUrls = "image_urls"
    }
//    "id": 1,
//         "name": "Стандартный номер с видом на бассейн",
//         "price": 186600,
//         "price_per": "За 7 ночей с перелетом",
//         "peculiarities": [
//           "Включен только завтрак",
//           "Кондиционер"
//         ],
//         "image_urls": [
//           "https://www.atorus.ru/sites/default/files/upload/image/News/56871/%D1%80%D0%B8%D0%BA%D1%81%D0%BE%D1%81%20%D1%81%D0%B8%D0%B3%D0%B5%D0%B9%D1%82.jpg",
//           "https://q.bstatic.com/xdata/images/hotel/max1024x768/267647265.jpg?k=c8233ff42c39f9bac99e703900a866dfbad8bcdd6740ba4e594659564e67f191&o=",
//           "https://worlds-trip.ru/wp-content/uploads/2022/10/white-hills-resort-5.jpeg"
//         ]
}
