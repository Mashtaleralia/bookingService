//
//  HotelInfoSnapshot.swift
//  hotel
//
//  Created by Admin on 02.09.2023.
//

import Foundation

struct HotelInfoSnapshot: Codable {
    var id: Int
    var hotelName: String
    var hotelAddress: String
    var ratingName: String
    var departure: String
    var arrivalCountry: String
    var tourDateStart: String
    var tourDateStop: String
    var nights: Int
    var room: String
    var nutrition: String
    var tourPrice: Int
    var fuelCharge: Int
    var serviceCharge: Int
    
    private enum CodingKeys: String, CodingKey {
        
        case hotelName = "hotel_name"
        case hotelAddress = "hotel_adress"
        case ratingName = "rating_name"
        case arrivalCountry = "arrival_country"
        case tourDateStart = "tour_date_start"
        case tourDateStop = "tour_date_stop"
        case nights = "number_of_nights"
        case tourPrice = "tour_price"
        case fuelCharge = "fuel_charge"
        case serviceCharge = "service_charge"
        case id
        case departure
        case room
        case nutrition
        
    }
}
