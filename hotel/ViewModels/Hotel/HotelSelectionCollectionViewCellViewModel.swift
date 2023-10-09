//
//  HotelSelectionCollectionViewCellViewModel.swift
//  hotel
//
//  Created by Admin on 16.09.2023.
//

import Foundation

protocol HotelSelectionCollectionViewCellViewModelDelegate: AnyObject {
    func moveToSelection() 
}

final class HotelSelectionCollectionViewCellViewModel {
    
    weak var delegate: HotelSelectionCollectionViewCellViewModelDelegate?
    
    public func selectRoom() {
        delegate?.moveToSelection()
    }
}
