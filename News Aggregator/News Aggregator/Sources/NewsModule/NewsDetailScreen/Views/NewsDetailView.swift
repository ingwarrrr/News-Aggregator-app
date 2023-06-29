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
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = ConstraintConstants.textFieldCornerRadius
        return imageView
    }()

    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    func setupDetailView(with news: UniqueNewsModel) {
        titleView.contentLabel.text = news.title
        descriptionView.contentLabel.text = news.description
        creatorView.contentLabel.text = news.creator?.first ?? "Неизвестно"
        pubDateView.contentLabel.text = news.pubDate?.formattedDate()
        linkView.contentLabel.text = news.link
        
        guard let imageData = news.imageData else {
            setupLayoutWithoutImageView()
            return
        }
        newsImageView.image = UIImage(data: imageData)
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
                .offset(ConstraintConstants.labelDefaultHeight)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
        
        creatorView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
                .offset(ConstraintConstants.largeOffset)
            make.left.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
        
        pubDateView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom)
                .offset(ConstraintConstants.largeOffset)
            make.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
        
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(creatorView.snp.bottom)
                .offset(ConstraintConstants.mediumOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.height.equalTo(ConstraintConstants.giganticOffset)
        }
        
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom)
                .offset(ConstraintConstants.mediumOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.height.greaterThanOrEqualTo(ConstraintConstants.giganticOffset)
        }
        
        linkView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide)
                .inset(ConstraintConstants.largeOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.height.equalTo(ConstraintConstants.largeOffset)
        }
    }
    
    private func setupLayoutWithoutImageView() {
        descriptionView.snp.makeConstraints { make in
            make.top.equalTo(creatorView.snp.bottom)
                .offset(ConstraintConstants.mediumOffset)
            make.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.height.greaterThanOrEqualTo(ConstraintConstants.giganticOffset)
        }
    }
}

fileprivate enum Layout {
    static let titleLabelLROffset = 31
    static let copyButtonBotOffset = 2
}
