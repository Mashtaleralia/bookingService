//
//  HotelRequest.swift
//  hotel
//
//  Created by Admin on 06.09.2023.
//

import Foundation

final class HotelRequest {
    
    private struct Constants {
        static let baseUrl = "https://run.mocky.io/v3/"
    }
    public var url: URL? {
        return URL(string: urlString)
    }
    
    private let key: Keys
    
    private var urlString: String {
        
        return Constants.baseUrl + key.rawValue
    }
    
    
    public init(key: Keys) {
        self.key = key
    }
    
}

extension HotelRequest {
    static let hotelDetailed = HotelRequest(key: .hotelDetailed)
    static let bookingInfo = HotelRequest(key: .bookingInfo)
    static let roomsInfo = HotelRequest(key: .roomsInfo)
}
