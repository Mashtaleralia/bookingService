//
//  BookingDetailViewViewModel.swift
//  hotel
//
//  Created by Admin on 31.08.2023.
//

import Foundation

final class BookingDetailViewViewModel {
    public var tourists: [Tourist] = []
    
    public var hotelSnapshot: HotelInfoSnapshot?
    
    public func fetchDetails(completion: @escaping () -> Void) {
        APICaller.shared.fetchBookingInfo(request: HotelRequest.bookingInfo, expecting: HotelInfoSnapshot.self) { result in
            switch result {
            case .success(let snapshot):
                self.hotelSnapshot = snapshot
                print(snapshot)
                completion()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}
