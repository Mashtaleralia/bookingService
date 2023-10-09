//
//  CustomerInfoCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 01.09.2023.
//

import UIKit

class CustomerInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomerInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        privacyLabel.text = "Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту"
        titleLabel.text = "Информация о покупателе"
        contentView.addSubview(phoneTextField)
        contentView.addSubview(emailTextField)
        contentView.addSubview(privacyLabel)
        contentView.addSubview(titleLabel)
        addConstraints()
        phoneTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Номер телефона"
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .secondarySystemBackground
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.textAlignment = .left
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .secondarySystemBackground
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let privacyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        return label
    }()
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 26),
            phoneTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            phoneTextField.heightAnchor.constraint(equalToConstant: 52),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 8),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            privacyLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            privacyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            privacyLabel.heightAnchor.constraint(equalToConstant: 34),
            privacyLabel.widthAnchor.constraint(equalToConstant: 343)
        ])
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
}

extension CustomerInfoCollectionViewCell: UITextFieldDelegate {
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if isBackSpace == -92 && (textField.text?.count)! > 0 {
            textField.text!.removeLast()
            return false
        }
        if textField == phoneTextField {
            if (textField.text?.count)! == 1 {
                textField.text = "+7 (\(textField.text!)"
            }
            else if (textField.text?.count)! == 7 {
                textField.text = "\(textField.text!))"
            } else if (textField.text?.count)! == 11 {
                textField.text = "\(textField.text!)-"
            }
            else if (textField.text?.count)! == 14 {
                textField.text = "\(textField.text!)-"
            } else if (textField.text?.count)! > 16 {
                return false
            }
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == phoneTextField {
            
            let set = CharacterSet(charactersIn: textField.text!)
         
            if !CharacterSet.decimalDigits.isSuperset(of: set) {
                phoneTextField.backgroundColor = .red
            } else {
                phoneTextField.backgroundColor = .secondarySystemBackground
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == phoneTextField {
//
//            let set = CharacterSet(charactersIn: textField.text!)
//
//            if !CharacterSet.decimalDigits.isSuperset(of: set) {
//                phoneTextField.backgroundColor = .red
//                return false
//            } else {
//                phoneTextField.backgroundColor = .secondarySystemBackground
//            }
//        }
        return true
    }
}
