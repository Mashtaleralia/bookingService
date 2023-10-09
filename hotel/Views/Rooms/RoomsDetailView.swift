//
//  RoomsDetailView.swift
//  hotel
//
//  Created by Admin on 16.09.2023.
//

import UIKit

protocol RoomsDetailViewDelegate: AnyObject {
    func jumpToRoomBooking()
}

class RoomsDetailView: UIView {
    
    private var viewModel = RoomsDetailViewViewModel()
    
    weak var delegate: RoomsDetailViewDelegate?
    
    var hasFetched = false {
        didSet {
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
    }
    
    private var cellViewModels: [RoomCollectionViewCellViewModel] {
        guard let rooms = viewModel.rooms else {
            return []
        }
        return rooms.compactMap {
            return RoomCollectionViewCellViewModel(titleName: $0.name, price: String($0.price), pricePer: $0.tourLength, peculiarities: $0.peculiarities, imageUrls: $0.imageUrls)
        }
    }
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
      
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: RoomCollectionViewCell.identifier)
        addSubview(collectionView)
        addSubview(spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.fetchRooms { [weak self] in
            self?.hasFetched = true
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
}

extension RoomsDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomCollectionViewCell.identifier, for: indexPath) as! RoomCollectionViewCell
        if !cellViewModels.isEmpty {
            cell.configure(with: cellViewModels[indexPath.row])
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let rooms = viewModel.rooms {
            return rooms.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 16
        let width = frame.width - inset*2
        let height: CGFloat = 560
        return CGSize(width: width, height: height)
        
    }
 
}


extension RoomsDetailView: RoomCollectionViewCellDelegate {
    func didTapSelectBookRoom() {
        delegate?.jumpToRoomBooking()
    }
    
}
