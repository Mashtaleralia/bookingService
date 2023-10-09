//
//  HotelSelectionCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 16.09.2023.
//

import UIKit



class HotelSelectionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HotelSelectionCollectionViewCell"
    
    private var viewModel: HotelSelectionCollectionViewCellViewModel?
    
    private let selectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 15
        button.setTitle("К выбору номера", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            selectionButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            selectionButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            selectionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            selectionButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(selectionButton)
        addConstraints()
        selectionButton.addTarget(self, action: #selector(didTapSelect), for: .touchUpInside)
    }
    
    @objc private func didTapSelect() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.selectRoom()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: HotelSelectionCollectionViewCellViewModel) {
        self.viewModel = viewModel
    }
}
