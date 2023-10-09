//
//  CarouselCollectionViewCellViewModel.swift
//  hotel
//
//  Created by Admin on 04.09.2023.
//

import UIKit

final class CarouselCollectionViewCellViewModel {
    public var hotelImage: UIImage?
    
    private var imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
        
    }

    public func fetchImage(completion: @escaping (() -> Void)){
        ImageManager.shared.downloadImage(with: imageUrl) { result in
            switch result {
            case .success(let data):
                self.hotelImage = UIImage(data: data)
                completion()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
}
