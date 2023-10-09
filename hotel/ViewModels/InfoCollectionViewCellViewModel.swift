//
//  InfoCollectionViewCellViewModel.swift
//  hotel
//
//  Created by Admin on 01.09.2023.
//

import Foundation

final class InfoCollectionViewCellViewModel {
    public var title: String
    public var value: String
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}
