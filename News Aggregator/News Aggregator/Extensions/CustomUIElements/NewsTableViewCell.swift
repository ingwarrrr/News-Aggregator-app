//
//  NewsTableViewCell.swift
//  News Aggregator
//
//  Created by Igor on 28.06.2023.
//

import UIKit

enum NewsDetailType {
    case news
    case favNews
}

final class NewsTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    var viewModel: NewsFeedViewModelType?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.mediumOfSize16
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularOfSize15
        label.numberOfLines = 6
        return label
    }()
    
    private lazy var creatorLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.mediumOfSize16
        label.textAlignment = .right
        return label
    }()
    
    private lazy var pubDateLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.mediumOfSize16
        return label
    }()
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.layer.borderWidth = ConstraintConstants.defaultBorderWidth
        imageView.layer.cornerRadius = ConstraintConstants.defaultCornerRadius
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.creatorLabel.text = nil
        self.pubDateLabel.text = nil
        self.previewImageView.image = nil
    }
    
    public func configure(
        with news: UniqueNewsModel,
        index: Int,
        type: NewsDetailType
    ) {
        self.titleLabel.text = news.title
        self.descriptionLabel.text = news.description
        self.creatorLabel.text = news.creator?.first
        self.pubDateLabel.text = news.pubDate?.formattedDate()
        setupPreview(with: news, index: index, type: type)
    }
    
    private func setupPreview(
        with news: UniqueNewsModel,
        index: Int,
        type: NewsDetailType
    ) {
        switch type {
        case .favNews:
            if let image = UserDefaultsManager.shared.newsImageArray[index] {
                self.previewImageView.image = image
            } else {
                self.previewImageView.image = UIImage(named: StringConstants.noneImage)
            }
        case .news:
            if let imageData = news.imageData {
                self.previewImageView.image = UIImage(data: imageData)
            }
            else if let urlString = news.imageURL,
                    let url = URL(string: urlString) {
                
                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    guard let data = data,
                          error == nil,
                          let newsImage = UIImage(data: data) else {
                        return
                    }
                    self?.viewModel?.newsArray?[index].imageData = data
                    
                    DispatchQueue.main.async {
                        self?.previewImageView.image = newsImage
                    }
                }.resume()
            } else {
                self.previewImageView.image = UIImage(named: StringConstants.noneImage)
            }
        }
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupHierarchy() {
        addSubviews([
            titleLabel,
            descriptionLabel,
            previewImageView,
            creatorLabel,
            pubDateLabel
        ])
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(ConstraintConstants.smallOffset)
            make.left.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
        }
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(ConstraintConstants.smallOffset)
            make.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.left.equalTo(descriptionLabel.snp.right)
                .offset(ConstraintConstants.smallOffset)
            make.height.equalTo(ConstraintConstants.imageSideSize)
            make.width.equalTo(ConstraintConstants.imageSideSize)
        }
        
        pubDateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.bottom.equalToSuperview()
                .inset(ConstraintConstants.smallOffset)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultOffset)
            make.left.equalTo(pubDateLabel.snp.right)
                .offset(ConstraintConstants.smallOffset)
            make.bottom.equalToSuperview()
                .inset(ConstraintConstants.smallOffset)
            make.width.equalTo(ConstraintConstants.giganticOffset)
        }
    }
}
