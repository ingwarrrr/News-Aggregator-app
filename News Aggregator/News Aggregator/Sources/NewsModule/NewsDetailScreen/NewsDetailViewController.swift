//
//  NewsDetailViewController.swift
//  News Aggregator
//
//  Created by Igor on 28.06.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    var isFavourited = false
    var indexImage = 0
    var typeOfNews: NewsDetailType
    var viewModel: NewsDetailViewModelType
    
    private lazy var newsDetailView: NewsDetailView = {
        let detailView = NewsDetailView()
        detailView.setupDetailView(with: viewModel.news, index: indexImage, type: typeOfNews)
        return detailView
    }()
    
    init(viewModel: NewsDetailViewModelType, typeOfNews: NewsDetailType) {
        self.viewModel = viewModel
        self.typeOfNews = typeOfNews
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubviews([
            newsDetailView
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: Fonts.regularOfSize16
        ]
        navigationController?.navigationBar.prefersLargeTitles = false
        title = StringConstants.newsDetailTitleText
        
        isFavourited = viewModel.checkFavourite()
        updateRighBarButton(isFavourite: isFavourited)
    }
    
    func updateRighBarButton(isFavourite : Bool) {
        let btnFavourite = UIButton(frame: CGRectMake(0,0,30,30))
        btnFavourite.addTarget(
            self,
            action: #selector(btnFavouriteDidTap),
            for: .touchUpInside
        )

        if isFavourite {
            btnFavourite.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }else{
            btnFavourite.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        let rightButton = UIBarButtonItem(customView: btnFavourite)
        self.navigationItem.setRightBarButton(rightButton, animated: true)
    }

    @objc
    private func btnFavouriteDidTap() {
        isFavourited.toggle()
        if isFavourited {
            viewModel.favourite()
            UserDefaultsManager.shared.newsImageArray
                .append(newsDetailView.newsImageView.image)
        } else{
            viewModel.unfavourite()
            UserDefaultsManager.shared.newsImageArray.remove(at: indexImage)
        }
        updateRighBarButton(isFavourite: isFavourited)
    }
    
    private func setupLayout() {
        newsDetailView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
}
