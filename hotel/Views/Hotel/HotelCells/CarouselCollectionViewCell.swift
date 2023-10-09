//
//  CarouselCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 04.09.2023.
//

import UIKit

final class CarouselCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CarouselCollectionViewCell"
    private let hotelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        contentView.addSubview(hotelImageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            hotelImageView.topAnchor.constraint(equalTo: topAnchor),
            hotelImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            hotelImageView.leftAnchor.constraint(equalTo: leftAnchor),
            hotelImageView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hotelImageView.image = nil
    }
    
    public func configure(with viewModel: CarouselCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] in
            DispatchQueue.main.async {
                self?.hotelImageView.image = viewModel.hotelImage
            }
        }
        
    }
}
