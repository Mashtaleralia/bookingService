//
//  TouristInfoCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 01.09.2023.
//

import UIKit

class TouristInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "TouristInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fields = createTextFields()
        
        contentView.addSubview(rootStack)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        rootStack.translatesAutoresizingMaskIntoConstraints = false
        setUpConstraints()
        updateAppearance()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    private var closedConstraint: NSLayoutConstraint?
    private var openConstraint: NSLayoutConstraint?
    
    private var fields: [UIView] = []
    private lazy var textFieldsStack: UIStackView = {
        fields.insert(headerLabel, at: 0)
        let stackView = UIStackView(arrangedSubviews: fields)
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rootStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            rootStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            rootStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        closedConstraint = headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        closedConstraint?.priority = .defaultLow // use low priority so stack stays pinned to top of cell
        openConstraint = fields.last!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        openConstraint?.priority = .defaultLow
    }
    
    private lazy var rootStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldsStack, disclosureIndicator])
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let disclosureIndicator: UIImageView = {
          let disclosureIndicator = UIImageView()
          disclosureIndicator.image = UIImage(systemName: "chevron.down")
          disclosureIndicator.contentMode = .scaleAspectFit
          disclosureIndicator.preferredSymbolConfiguration = .init(textStyle: .body, scale: .small)
          return disclosureIndicator
      }()
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.text = "Первый турист"
        //label.textAlignment = .left
        return label
    }()
    
    private func createTextFields() -> [UITextField] {
        let placeholders = ["Имя", "Фамилия", "Дата рождения", "Гражданство", "Номер загранпаспорта", "Срок действия загранпаспорта"]
        var textFields = [UITextField]()
        for i in 0 ... 5 {
            let textField = UITextField()
            textField.heightAnchor.constraint(equalToConstant: 52).isActive = true
            textField.placeholder = placeholders[i]
            textField.textAlignment = .left
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
            textField.leftViewMode = .always
            textField.backgroundColor = .secondarySystemBackground
            textField.autocapitalizationType = .none
            textField.autocorrectionType = .no
            textField.returnKeyType = .continue
            textField.layer.cornerRadius = 10
            textFields.append(textField)
        }
       
        return textFields
    }
    
    private func updateAppearance() {
        closedConstraint?.isActive = !isSelected
        openConstraint?.isActive = isSelected
        for i in 1 ..< fields.count {
            fields[i].isHidden = !isSelected
        }
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * 0.999 )
            self.disclosureIndicator.transform = self.isSelected ? upsideDown : .identity
        }
    }
}
