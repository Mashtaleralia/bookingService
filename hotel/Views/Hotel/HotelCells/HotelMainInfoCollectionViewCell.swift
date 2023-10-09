//
//  HotelMainInfoCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 08.09.2023.
//

import UIKit

final class HotelMainInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "HotelMainInfoCollectionViewCell"
    
    private var ratingView = RatingView()
    
    private let hotelNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    private let hotelAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.textAlignment = .left
        return label
    }()
    
    public let minimalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let priceOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "jgjggj"
        label.textAlignment = .right
        return label
    }()
    
   
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hotelNameLabel.text = nil
        hotelAddressLabel.text = nil
        minimalPriceLabel.text = nil
        priceOptionLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        hotelNameLabel.text = nil
//        hotelAddressLabel.text = nil
//        minimalPriceLabel.text = nil
//        priceOptionLabel.text = nil
        contentView.addSubview(hotelNameLabel)
        contentView.addSubview(hotelAddressLabel)
        contentView.addSubview(minimalPriceLabel)
        contentView.addSubview(priceOptionLabel)
        contentView.addSubview(ratingView)
       // backgroundColor = .green
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            ratingView.heightAnchor.constraint(equalToConstant: 30),
           // ratingView.widthAnchor.constraint(equalToConstant: 200),
            ratingView.topAnchor.constraint(equalTo: topAnchor),
            ratingView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            hotelNameLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 8),
            hotelNameLabel.widthAnchor.constraint(equalToConstant: 350),
            hotelNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            //hotelNameLabel.heightAnchor.constraint(equalToConstant: 60),
            
            hotelAddressLabel.topAnchor.constraint(equalTo: hotelNameLabel.bottomAnchor, constant: 8),
            hotelAddressLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            hotelAddressLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            //hotelAddressLabel.heightAnchor.constraint(equalToConstant: 17),
            
            minimalPriceLabel.topAnchor.constraint(equalTo: hotelAddressLabel.bottomAnchor, constant: 16),
            minimalPriceLabel.widthAnchor.constraint(equalToConstant: 180),
            minimalPriceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
           // minimalPriceLabel.heightAnchor.constraint(equalToConstant: 36),
            
            priceOptionLabel.bottomAnchor.constraint(equalTo: minimalPriceLabel.bottomAnchor),
            priceOptionLabel.widthAnchor.constraint(equalToConstant: 150),
           // priceOptionLabel.heightAnchor.constraint(equalToConstant: 25),
            priceOptionLabel.leftAnchor.constraint(equalTo: minimalPriceLabel.rightAnchor)
            
            
//            priceOptionLabel.topAnchor.constraint(equalTo: minimalPriceLabel.centerYAnchor),
//            //priceOptionLabel.leftAnchor.constraint(equalTo: minimalPriceLabel.rightAnchor, constant: 8),
//            priceOptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
//            priceOptionLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }

    public func configure(with model: HotelMainInfoCollectionViewCellViewModel) {
        hotelNameLabel.text = model.hotelName
        hotelAddressLabel.text = model.hotelAddress
        minimalPriceLabel.text = "От " + model.minimalPrice + " ₽"
        priceOptionLabel.text = model.priceOption
        ratingView.textLabel.text = model.rating
        print("/// \(model.priceOption)")
    }

    
}
