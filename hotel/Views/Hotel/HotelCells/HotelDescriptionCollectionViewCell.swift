//
//  HotelDescriptionCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 12.09.2023.
//

import UIKit

class HotelDescriptionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HotelDescriptionCollectionViewCell"
    
    private var isConfigured = false
    
    private var viewModel: HotelDescriptionCollectionViewCellViewModel? {
        didSet {
            if !isConfigured {
                if let stackView = self.createPeculiaritiesStack() {
                   
                    self.peculiaritiesStackView = stackView
                    
                     if let peculiaritiesStackView = peculiaritiesStackView {
                         contentView.addSubview(peculiaritiesStackView)
                     }
                     contentView.addSubview(descriptionLabel)
                     addConstraints()
                    }

            }
            
        }
    }
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var peculiaritiesStackView: UIStackView?
    
    private var peculiarViews: [PeculiarityView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //translatesAutoresizingMaskIntoConstraints = false
        //backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createPeculiaritiesStack() -> UIStackView? {
        guard let peculiarities = viewModel?.peculiarities else {
            print("lol")
            return nil
        }
        print("// \(peculiarities)")
        for i in 0 ..< peculiarities.count {
            let view = PeculiarityView()
            view.textLabel.text = peculiarities[i]
            peculiarViews.append(view)
        }
        print(peculiarViews.count)
        let stackView = UIStackView(arrangedSubviews: peculiarViews)
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func addConstraints() {
        guard let peculiaritiesStackView = peculiaritiesStackView else {
            return
        }
        NSLayoutConstraint.activate([
            peculiaritiesStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            peculiaritiesStackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            peculiaritiesStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            //peculiaritiesStackView.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.topAnchor.constraint(equalTo: peculiaritiesStackView.bottomAnchor, constant: 12),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 350),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    public func configure(with viewModel: HotelDescriptionCollectionViewCellViewModel) {
        self.viewModel = viewModel
        isConfigured = true
        descriptionLabel.text = viewModel.description
    }
    
    
    
}
