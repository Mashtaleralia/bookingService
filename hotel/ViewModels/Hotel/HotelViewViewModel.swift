//
//  HotelViewViewModel.swift
//  hotel
//
//  Created by Admin on 04.09.2023.
//

import Foundation

protocol HotelViewViewModelDelegate: AnyObject {
    func didFinishFetchingHotelInfo()
}

final class HotelViewViewModel {
    
    weak var delegate: HotelViewViewModelDelegate?
    
    public var imageUrls: [String]?
    
    public var hotelData: HotelDetailedInfo? {
        didSet {
            self.imageUrls = hotelData?.imageUrls
        }
    }
    
    var hasFetched = false {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.didFinishFetchingHotelInfo()
            }
        }
    }
    
    public func fetchHotelInfo() {
        APICaller.shared.fetchBookingInfo(request: HotelRequest.hotelDetailed, expecting: HotelDetailedInfo.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.hotelData = data
                self?.hasFetched = true
                print(data)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
}
