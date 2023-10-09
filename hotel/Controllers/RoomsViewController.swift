//
//  RoomsViewController.swift
//  hotel
//
//  Created by Admin on 16.09.2023.
//

import UIKit

class RoomsViewController: UIViewController, RoomsDetailViewDelegate {
    
    private var detailView = RoomsDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        addConstraints()
        detailView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    func jumpToRoomBooking() {
        let vc = BookingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

