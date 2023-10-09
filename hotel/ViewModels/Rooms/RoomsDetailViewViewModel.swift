//
//  RoomsDetailView.swift
//  hotel
//
//  Created by Admin on 24.09.2023.
//

import UIKit

final class RoomsDetailViewViewModel {
    public var rooms: [Room]?
    
    public func fetchRooms(completion: @escaping () -> Void) {
        APICaller.shared.fetchBookingInfo(request: HotelRequest.roomsInfo, expecting: Rooms.self) { result in
            switch result {
            case .success(let rooms):
                self.rooms = rooms.rooms
                print(rooms)
                completion()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    

}
