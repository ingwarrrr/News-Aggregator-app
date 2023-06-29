//
//  NewsDetailView.swift
//  News Aggregator
//
//  Created by Igor on 28.06.2023.
//

import UIKit

class NewsDetailView: UIView {
    private lazy var titleView = NewsDetailComponent(.title)
    private lazy var descriptionView: NewsDetailComponent = {
        let view = NewsDetailComponent(.description)
        view.contentLabel.numberOfLines = 9
        view.contentLabel.textAlignment = .natural
        return view
    }()
    private lazy var creatorView = NewsDetailComponent(.creator)
    private lazy var pubDateView = NewsDetailComponent(.pubDate)
    private lazy var linkView: NewsDetailComponent = {
        let view = NewsDetailComponent(.link)
        view.contentLabel.numberOfLines = 3
        return view
    }()
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = ConstraintConstants.defaultCornerRadius
        return imageView
    }()

    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    func setupDetailView(with news: UniqueNewsModel, index: Int, type: NewsDetailType) {
        titleView.contentLabel.text = news.title
        descriptionView.contentLabel.text = news.description
        creatorView.contentLabel.text = news.creator?.first ?? "Неизвестно"
        pubDateView.contentLabel.text = news.pubDate?.formattedDate()
        linkView.contentLabel.text = news.link
        
        switch type {
        case .news:
            if let imageData = news.imageData {
                newsImageView.image = UIImage(data: imageData)
                setupLayoutWithImageView()
            } else {
                newsImageView.image = UIImage(named: StringConstants.noneImage)
                newsImageView.isHidden = true
                setupLayoutWithoutImageView()
            }
        case .favNews:
            if news.imageURL != nil {
                let imageNews = UserDefaultsManager.shared.newsImageArray[index]
                newsImageView.image = imageNews
                setupLayoutWithImageView()
            } else {
                setupLayoutWithoutImageView()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubviews([
            titleView,
            newsImageView,
            descriptionView,
            creatorView,
            pubDateView,
            linkView
        ])
    }
    
    private func setupLayout() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
                .offset(ConstraintConstants.labelDefaultOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
        
        creatorView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
                .offset(ConstraintConstants.largeOffset)
            make.left.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
        
        pubDateView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
                .offset(ConstraintConstants.largeOffset)
            make.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
        
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(creatorView.snp.bottom)
                .offset(ConstraintConstants.mediumOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.height.equalTo(ConstraintConstants.giganticOffset)
        }
        
        linkView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
                .inset(ConstraintConstants.largeOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
    }
    
    private func setupLayoutWithoutImageView() {
        descriptionView.contentLabel.numberOfLines = 15
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(creatorView.snp.bottom)
                .offset(ConstraintConstants.mediumOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.height.greaterThanOrEqualTo(ConstraintConstants.giganticOffset)
        }
    }
    private func setupLayoutWithImageView() {
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom)
                .offset(ConstraintConstants.mediumOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.height.greaterThanOrEqualTo(ConstraintConstants.giganticOffset)
        }
    }
}

fileprivate enum Layout {
    static let titleLabelLROffset = 31
    static let copyButtonBotOffset = 2
}
