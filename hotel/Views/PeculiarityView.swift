//
//  PeculiarityView.swift
//  hotel
//
//  Created by Admin on 12.09.2023.
//

import UIKit

class PeculiarityView: UIView {

    public var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = .gray
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(textLabel)
        layer.cornerRadius = 5
        backgroundColor = .secondarySystemBackground
        addConstarints()
        tintColor = .gray
        
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
                heightAnchor.constraint(equalToConstant: 30),
                textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
                textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
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
    

}
