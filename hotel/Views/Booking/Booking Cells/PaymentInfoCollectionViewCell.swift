//
//  PaymentInfoCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 01.09.2023.
//

import UIKit

class PaymentInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PaymentInfoCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.51, green: 0.529, blue: 0.588, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        addConstraints()
        backgroundColor = .blue
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 76),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with viewModel: InfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
