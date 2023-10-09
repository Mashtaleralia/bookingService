//
//  ViewController.swift
//  hotel
//
//  Created by Admin on 31.08.2023.
//

import UIKit

class BookingViewController: UIViewController {
    
    private let bookingView = BookingDetailView()
    
    let notificationCenter = NotificationCenter.default
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Бронирование"
        view.addSubview(bookingView)
        addConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
  
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            bookingView.topAnchor.constraint(equalTo: view.topAnchor),
            bookingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bookingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bookingView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }


}

