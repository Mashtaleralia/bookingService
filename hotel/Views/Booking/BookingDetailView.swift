//
//  BookingDetailView.swift
//  hotel
//
//  Created by Admin on 31.08.2023.
//

import UIKit

final class BookingDetailView: UIView {
    
    private var collectionView: UICollectionView?
    
    private var viewModel = BookingDetailViewViewModel()
    
    private var isLoading: Bool = true {
        didSet {
            print("kek")
            let sections = self.setUpSections()
            self.sections = sections
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        
        addSubview(collectionView)
        backgroundColor = .secondarySystemBackground
        self.collectionView?.addSubview(spinner)
        addConstraints()
        
        
        spinner.startAnimating()
        viewModel.fetchDetails { [weak self] in
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                
            }
    
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        if !isLoading {
           
        }
//        let sections = self.setUpSections()
//        self.sections = sections
        
        
    }
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .medium
        spinner.color = .black
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private var sections: [SectionType] = [] {
        didSet {
            
        }
    }
    //{
        //return setUpSections()
   // }
    
    enum SectionType {
        case hotel(viewModel: HotelMainInfoCollectionViewCellViewModel)
        case info(viewModels: [InfoCollectionViewCellViewModel])
        case customerInfo
        case touristInfo
        case addTourist
        case paymentInfo(viewModels: [InfoCollectionViewCellViewModel])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpSections() -> [SectionType] {
     
        guard let hotelInfo = viewModel.hotelSnapshot else {
            print("hell")
            return []
        }
//
//        HotelMainInfoCollectionViewCellViewModel(hotelName: data.name, hotelAddress: data.adress, minimalPrice: String(data.minimalPrice), priceOption: data.priceOption, rating: String(data.rating) + " " +   data.ratingName)
        let sections: [SectionType] = [.hotel(viewModel: .init(hotelName: hotelInfo.hotelName, hotelAddress: hotelInfo.hotelAddress, minimalPrice: "", priceOption: "", rating: hotelInfo.ratingName)), .info(viewModels: [.init(title: "Вылет из", value: hotelInfo.departure), .init(title: "Страна, город", value: hotelInfo.arrivalCountry), .init(title: "Даты", value: hotelInfo.tourDateStart), .init(title: "Кол-во ночей", value: String(hotelInfo.nights)), .init(title: "Отель", value: hotelInfo.hotelName), .init(title: "Номер", value: hotelInfo.room), .init(title: "Питание", value: hotelInfo.nutrition),]), .customerInfo, .touristInfo, .addTourist, .paymentInfo(viewModels: [.init(title: "Тур", value: String(hotelInfo.tourPrice) + " ₽"), .init(title: "Топливный сбор", value: String(hotelInfo.fuelCharge) + " ₽"), .init(title: "Сервисный сбор", value: String(hotelInfo.serviceCharge) + " ₽"), .init(title: "К оплате", value: String(hotelInfo.tourPrice + hotelInfo.fuelCharge + hotelInfo.serviceCharge) + " ₽")])]
        print("sections all ready")
        
        
       return sections
    }
    
    public func configure(with viewModel : BookingDetailViewViewModel) {
        
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HotelMainInfoCollectionViewCell.self, forCellWithReuseIdentifier: HotelMainInfoCollectionViewCell.identifier)
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell.identifier)
        collectionView.register(CustomerInfoCollectionViewCell.self, forCellWithReuseIdentifier: CustomerInfoCollectionViewCell.identifier)
        collectionView.register(TouristInfoCollectionViewCell.self, forCellWithReuseIdentifier: TouristInfoCollectionViewCell.identifier)
        collectionView.register(PaymentInfoCollectionViewCell.self, forCellWithReuseIdentifier: PaymentInfoCollectionViewCell.identifier)
        collectionView.register(AddTouristCollectionViewCell.self, forCellWithReuseIdentifier: AddTouristCollectionViewCell.identifier)
        
        
        return collectionView
    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            spinner.heightAnchor.constraint(equalToConstant: 30),
            spinner.widthAnchor.constraint(equalToConstant: 30),
            spinner.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor)
        ])
    }
    
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        switch sections[section] {
        case .hotel:
            return createHotelLayout()
        case .info:
            return createInfoLayout()
        case .touristInfo:
            return createTouristInfoLayout()
        case .paymentInfo:
            return createPaymentInfoLayout()
        case .customerInfo:
            return createCustomerInfoLayout()
        case .addTourist:
            return createAddTouristLayout()
        }
        
    }
    
    private func createHotelLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120.0)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(280.0/6)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCustomerInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(232.0)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createTouristInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(58)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(58)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createAddTouristLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(58)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(58)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createPaymentInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
       
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(156.0/4)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    
}

extension BookingDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .paymentInfo(let viewModels):
            return viewModels.count
        case .info(let viewModels):
            return viewModels.count
        case .touristInfo:
            return viewModel.tourists.count
        default:
            return 1
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        collectionView.performBatchUpdates(nil)
        
        return false
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .hotel(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelMainInfoCollectionViewCell.identifier, for: indexPath) as! HotelMainInfoCollectionViewCell
            cell.minimalPriceLabel.isHidden = true
            cell.configure(with: viewModel)
            return cell
        case .info(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.identifier, for: indexPath) as! InfoCollectionViewCell
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .customerInfo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomerInfoCollectionViewCell.identifier, for: indexPath) as! CustomerInfoCollectionViewCell
            return cell
        case .touristInfo:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TouristInfoCollectionViewCell.identifier, for: indexPath) as! TouristInfoCollectionViewCell
            return cell
        case .paymentInfo(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.identifier, for: indexPath) as! InfoCollectionViewCell
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .addTourist:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddTouristCollectionViewCell.identifier, for: indexPath) as! AddTouristCollectionViewCell
            cell.delegate = self
            return cell
        }
    }
    
}

extension BookingDetailView: AddTouristCollectionViewCellDelegate {
    func addTourist() {
        guard viewModel.tourists.count <= 4 else {
            return
        }
        viewModel.tourists.append(Tourist())
        UIView.animate(withDuration: 0.3) {
            self.collectionView?.reloadData()
        }

    }
    
}
