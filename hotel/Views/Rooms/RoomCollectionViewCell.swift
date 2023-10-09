//
//  RoomCollectionViewCell.swift
//  hotel
//
//  Created by Admin on 25.09.2023.
//

import UIKit

protocol RoomCollectionViewCellDelegate: AnyObject {
    func didTapSelectBookRoom()
}

final class RoomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RoomCollectionViewCell"
    
    weak var delegate: RoomCollectionViewCellDelegate?
    
    private var viewModel: RoomCollectionViewCellViewModel? {
        didSet {
            
            self.peculiarititesStackView = createPeculiaritiesStack()
            guard let stackView = peculiarititesStackView else {
                return
            }
            addSubview(stackView)
            //configureScrollView()
            addConstraints()
            setUpPageControl()
           
        }
    }
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.backgroundColor = .white
        pageControl.translatesAutoresizingMaskIntoConstraints = false
       pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.layer.cornerRadius = 5
        pageControl.backgroundStyle = .minimal
       
        return pageControl
    }()
    
    
    private var roomTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pricePerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        
        button.layer.cornerRadius = 15
        button.setTitle("Выбрать номер", for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let imagesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .secondarySystemBackground
        scrollView.layer.cornerRadius = 15
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var detailsView = ShowDetailsView()
    
    private var peculiarititesStackView: UIStackView?
    
    private var peculiarViews: [PeculiarityView] = []
    
    
    
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
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureScrollView()
    }
    
    private func configureScrollView() {
        guard let urlStrings = viewModel?.imageUrls else {
            return
        }
        let pages = urlStrings.count
        let urls = urlStrings.compactMap {
            return URL(string: $0)
        }
        imagesScrollView.contentSize = CGSize(width: imagesScrollView.frame.width * CGFloat(pages), height: imagesScrollView.frame.height)
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.showsHorizontalScrollIndicator = false
        let colors: [UIColor] = [.red, .green, .blue, .yellow]
        for x in 0 ..< pages {
            //let page = UIView(frame: CGRect(x: CGFloat(x) * imagesScrollView.frame.width, y: 0, width: imagesScrollView.frame.width, height: imagesScrollView.frame.height))
            
            let page = UIImageView()
            page.contentMode = .scaleToFill
            imagesScrollView.addSubview(page)
            //page.translatesAutoresizingMaskIntoConstraints = false
            page.frame = CGRect(x: CGFloat(x) * imagesScrollView.frame.width, y: 0, width: imagesScrollView.frame.width, height: imagesScrollView.frame.height)
            ImageManager.shared.downloadImage(with: urls[x]) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        page.image = UIImage(data: data)
                    }
                case .failure(let error):
                    print(String(describing: error))
                }
            }
        }
    }
    
   
    
    private func addConstraints() {
        guard let stackView = peculiarititesStackView else {
            return
        }
        NSLayoutConstraint.activate([
            imagesScrollView.topAnchor.constraint(equalTo: topAnchor),
            imagesScrollView.leftAnchor.constraint(equalTo: leftAnchor),
            imagesScrollView.rightAnchor.constraint(equalTo: rightAnchor),
            imagesScrollView.heightAnchor.constraint(equalToConstant: 250),
            pageControl.heightAnchor.constraint(equalToConstant: 23),
            pageControl.widthAnchor.constraint(equalToConstant: 100),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: imagesScrollView.bottomAnchor, constant: -8),
            roomTitleLabel.topAnchor.constraint(equalTo: imagesScrollView.bottomAnchor, constant: 8),
            roomTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            roomTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            roomTitleLabel.heightAnchor.constraint(equalToConstant: 55),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: roomTitleLabel.bottomAnchor, constant: 8),
            detailsView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            detailsView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            priceLabel.topAnchor.constraint(equalTo: detailsView.bottomAnchor, constant: 21),
            priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            pricePerLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            pricePerLabel.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 8),
//            detailsView.heightAnchor.constraint(equalToConstant: 30),
//            detailsView.widthAnchor.constraint(equalToConstant: 192),
            selectionButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            selectionButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 16 ),
            selectionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            selectionButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(detailsView)
        addSubview(roomTitleLabel)
        addSubview(priceLabel)
        addSubview(pricePerLabel)
        addSubview(selectionButton)
       addSubview(imagesScrollView)
        addSubview(pageControl)
       // addConstraints()
        imagesScrollView.delegate = self
        pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
        selectionButton.addTarget(self, action: #selector(didTapSelect), for: .touchUpInside)
    }
    
    @objc private func didTapSelect() {
        delegate?.didTapSelectBookRoom()
    }
    
    @objc private func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        imagesScrollView.setContentOffset(CGPoint(x: CGFloat(current) * frame.width,  y: 0), animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        roomTitleLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpPageControl() {
        if let viewModel = viewModel {
            pageControl.numberOfPages = viewModel.imageUrls.count
            
        }
    }
    
    public func configure(with viewModel: RoomCollectionViewCellViewModel) {
        self.viewModel = viewModel
        roomTitleLabel.text = viewModel.titleName
        priceLabel.text = viewModel.price
        pricePerLabel.text = viewModel.pricePer
    }
    
}

extension RoomCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floorf(Float(scrollView.contentOffset.x) / Float(scrollView.frame.width)))
    }
}
