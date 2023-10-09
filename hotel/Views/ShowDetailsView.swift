//
//  ShowDetailsView.swift
//  hotel
//
//  Created by Admin on 25.09.2023.
//

import UIKit

class ShowDetailsView: UIView {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.05, green: 0.45, blue: 1, alpha: 1)
        label.text = "Подробнее о номере"
        return label
    }()
    
    private var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViewAppearance()
        addSubview(titleLabel)
        addSubview(arrowImageView)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.rightAnchor.constraint(equalTo: arrowImageView.leftAnchor, constant: -2),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -2),
            
        ])
    }
    
    
    private func setUpViewAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 5
        backgroundColor = UIColor(red: 0.051, green: 0.447, blue: 1, alpha: 0.1)
        tintColor = UIColor(red: 0.05, green: 0.45, blue: 1, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
