//
//  HotelView.swift
//  hotel
//
//  Created by Admin on 04.09.2023.
//

import UIKit

protocol HotelDetailViewDelegate: AnyObject {
    func jumpToRoomsVC()
}

class HotelDetailView: UIView {
    
    enum HotelSection {
        case carousel(viewModels: [CarouselCollectionViewCellViewModel])
        case basicData(viewModel: HotelMainInfoCollectionViewCellViewModel)
        case hotelDescription(viewModel: HotelDescriptionCollectionViewCellViewModel)
        case hotelDescriptionDetails
        case hotelSelection(viewModel: HotelSelectionCollectionViewCellViewModel)
    }
    
    weak var delegate: HotelDetailViewDelegate?
    
    private let viewModel = HotelViewViewModel()
    
    private var collectionView: UICollectionView?
    
    private var sections: [HotelSection] = []
    
    private var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.style = .medium
        spinner.color = .black
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.backgroundColor = .red
        return pageControl
    }()
    
    
    private func setUpSections() -> [HotelSection]? {
        guard let data = viewModel.hotelData,  let imageUrls = viewModel.imageUrls else {
            print("mem")
            return nil
        }
        
        let sections: [HotelSection] = [.carousel(viewModels: imageUrls.compactMap({
            return CarouselCollectionViewCellViewModel(imageUrl: URL(string: $0))
        })), .basicData(viewModel: HotelMainInfoCollectionViewCellViewModel(hotelName: data.name, hotelAddress: data.adress, minimalPrice: String(data.minimalPrice), priceOption: data.priceOption, rating: String(data.rating) + " " +   data.ratingName)), .hotelDescription(viewModel: HotelDescriptionCollectionViewCellViewModel(peculiarities: data.aboutHotel.peculiarities, description: data.aboutHotel.description)), .hotelSelection(viewModel: HotelSelectionCollectionViewCellViewModel())]
       
//        let group = NSCollectionLayoutGroup.horizontal(
//                 layoutSize: NSCollectionLayoutSize(
//                     widthDimension: .fractionalWidth(0.8),
//                     heightDimension: .absolute(150.0)), subitems: [item])
//             let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPagingCentered
        return sections
    }
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        let collectionView = createCollectionView()
        //collectionView.addSubview(pageControl)
        self.collectionView = collectionView
        addSubview(collectionView)
        addConstraints()
       
        spinner.startAnimating()
        translatesAutoresizingMaskIntoConstraints = false
        viewModel.delegate = self
        viewModel.fetchHotelInfo()
      
    }
    
    
    private func createCollectionView() -> UICollectionView {
       
        let layout = UICollectionViewCompositionalLayout {section, _ in
            return self.layout(for: section)
        }
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 10
        layout.configuration = configuration
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CarouselCollectionViewCell.self, forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        collectionView.register(HotelMainInfoCollectionViewCell.self, forCellWithReuseIdentifier: HotelMainInfoCollectionViewCell.identifier)
        collectionView.register(HotelDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: HotelDescriptionCollectionViewCell.identifier)
        collectionView.register(HotelSelectionCollectionViewCell.self, forCellWithReuseIdentifier: HotelSelectionCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        //collectionView.backgroundColor = .brown
        return collectionView

    }
    
    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
//            pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
//            pageControl.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: 30),
//            pageControl.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HotelDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .carousel(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .basicData(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelMainInfoCollectionViewCell.identifier, for: indexPath) as! HotelMainInfoCollectionViewCell
            cell.configure(with: viewModel)
            return cell
        case .hotelDescription(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelDescriptionCollectionViewCell.identifier, for: indexPath) as! HotelDescriptionCollectionViewCell
            cell.configure(with: viewModel)
            return cell
        case .hotelDescriptionDetails:
            return UICollectionViewCell()
        case .hotelSelection(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelSelectionCollectionViewCell.identifier, for: indexPath) as! HotelSelectionCollectionViewCell
            viewModel.delegate = self
            cell.configure(with: viewModel)
            return cell
        }
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .carousel(let viewModels):
            self.pageControl.numberOfPages = viewModels.count
            return viewModels.count
        case .basicData:
            return 1
        case .hotelDescription:
            return 1
        case .hotelDescriptionDetails:
            return 0
        case .hotelSelection:
            return 1
        }
        
    }
    
}

extension HotelDetailView: HotelViewViewModelDelegate {
    
    func didFinishFetchingHotelInfo() {
        self.spinner.stopAnimating()
        self.collectionView?.isHidden = false
        guard let sections = setUpSections() else {
            print("no sections")
            return
        }
        self.sections = sections
        self.collectionView?.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView?.alpha = 1
        }
    }
    
}

extension HotelDetailView {
    private func layout(for section: Int) -> NSCollectionLayoutSection? {
        switch sections[section] {
        case .carousel:
            return createCarouselLayout()
        case .basicData:
            return createMainInfoLayout()
        case .hotelDescription:
            return createHotelDescriptionLayout()
        case .hotelDescriptionDetails:
            return nil
        case .hotelSelection:
            return createHotelSelectionLayout()
        }
        
    }
    
    private func createCarouselLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                let group = NSCollectionLayoutGroup.horizontal(
                         layoutSize: NSCollectionLayoutSize(
                             widthDimension: .fractionalWidth(0.95),
                             heightDimension: .absolute(260.0)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
       
        return section
    }
    
    private func createMainInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5)))
        //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(130)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createHotelDescriptionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.7)))
        //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(160)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createHotelSelectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.4)))
        //item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(88)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }

}

extension HotelDetailView: HotelSelectionCollectionViewCellViewModelDelegate {
    func moveToSelection() {
        delegate?.jumpToRoomsVC()
    }
    
    
}
