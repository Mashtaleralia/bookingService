//
//  RatingView.swift
//  hotel
//
//  Created by Admin on 08.09.2023.
//

import UIKit

class RatingView: UIView {
    
    private lazy var rootStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [starIcon, textLabel])
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    private let starIcon: UIImageView = {
        let starImage = UIImage(systemName: "star.fill")?.withTintColor(UIColor(red: 1, green: 0.66, blue: 0, alpha: 1))
        let starIcon = UIImageView(image: starImage)
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        return starIcon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
       addSubview(textLabel)
        addSubview(starIcon)
        layer.cornerRadius = 5
        //layer.borderWidth = 2
        //layer.borderColor =  UIColor(red: 1, green: 0.66, blue: 0, alpha: 1).cgColor
        backgroundColor = UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.2)
        addConstarints()
        tintColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstarints() {
            NSLayoutConstraint.activate([
//                leftAnchor.constraint(equalTo: starIcon.leftAnchor, constant: 10),
//                rightAnchor.constraint(equalTo: textLabel.rightAnchor, constant: -10),
//                topAnchor.constraint(equalTo: textLabel.topAnchor, constant: 5),
//                bottomAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: -5),
                rightAnchor.constraint(equalTo: textLabel.rightAnchor),
                heightAnchor.constraint(equalToConstant: 30),
                starIcon.heightAnchor.constraint(equalToConstant: 15),
                starIcon.widthAnchor.constraint(equalToConstant: 15),
                starIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
                starIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
                textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                textLabel.leftAnchor.constraint(equalTo: starIcon.rightAnchor, constant: 2),
                textLabel.widthAnchor.constraint(equalToConstant: 130),
                textLabel.heightAnchor.constraint(equalToConstant: 20),

               
//                topAnchor.constraint(equalTo: topAnchor),
//                leadingAnchor.constraint(equalTo: leadingAnchor),
//                trailingAnchor.constraint(equalTo: trailingAnchor),
//                bottomAnchor.constraint(equalTo: bottomAnchor),
//                rootStack.topAnchor.constraint(equalTo: topAnchor),
//                rootStack.heightAnchor.constraint(equalToConstant: 30),
//                rootStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
//                rootStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
                
            ])
    }
    
//    let view = UIView()
//    view.layer.cornerRadius = 5
//    view.backgroundColor = UIColor(red: 1, green: 0.78, blue: 0, alpha: 0.2)
//    view.translatesAutoresizingMaskIntoConstraints = false
//    let textLabel = UILabel()
//    textLabel.textColor = UIColor(red: 1, green: 0.66, blue: 0, alpha: 1)
//    view.addSubview(textLabel)
//    textLabel.translatesAutoresizingMaskIntoConstraints = false
//
//    let starImage = UIImage(systemName: "star")?.withTintColor(UIColor(red: 1, green: 0.66, blue: 0, alpha: 1))
//    let starIcon = UIImageView(image: starImage)
//    starIcon.translatesAutoresizingMaskIntoConstraints = false
//    view.addSubview(starIcon)
//    NSLayoutConstraint.activate([
//        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        textLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
//        textLabel.widthAnchor.constraint(equalToConstant: 115),
//        textLabel.heightAnchor.constraint(equalToConstant: 20),
//
//        starIcon.heightAnchor.constraint(equalToConstant: 15),
//        starIcon.widthAnchor.constraint(equalToConstant: 15),
//        starIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)
//
//    ])
//    textLabel.text = text

}
