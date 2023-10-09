//
//  HotelViewController.swift
//  hotel
//
//  Created by Admin on 04.09.2023.
//

import UIKit
import AppTrackingTransparency

class HotelViewController: UIViewController, HotelDetailViewDelegate {
    
    func jumpToRoomsVC() {
        let vc = RoomsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private let hotelView = HotelDetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        ATTrackingManager.requestTrackingAuthorization { status in
            switch status {
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorized:
                
                break
            @unknown default:
                break
            }
        }
        title = "Отель"
        hotelView.delegate = self
        view.addSubview(hotelView)
        addConstraints()
     
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            hotelView.topAnchor.constraint(equalTo: view.topAnchor),
            hotelView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hotelView.leftAnchor.constraint(equalTo: view.leftAnchor),
            hotelView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
        ])
    }
    
    


}
