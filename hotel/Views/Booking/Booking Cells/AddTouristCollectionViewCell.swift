//
//  AddTouristCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 02.09.2023.
//

import UIKit

protocol AddTouristCollectionViewCellDelegate: AnyObject {
    func addTourist()
}

class AddTouristCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AddTouristCollectionViewCell"
    
    weak var delegate: AddTouristCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(headerLabel)
        contentView.addSubview(addButton)
        addConstraints()
        
        addButton.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
    }
    
    @objc func didTapAdd() {
        delegate?.addTourist()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.text = "Добавить туриста"
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        var image = UIImage(named: "plus")
        
        button.setImage(image?.withTintColor(.white), for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    
    public func addConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addButton.heightAnchor.constraint(equalToConstant: 32),
            addButton.widthAnchor.constraint(equalToConstant: 32),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            addButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 130),
        ])
        
    }
    
}
