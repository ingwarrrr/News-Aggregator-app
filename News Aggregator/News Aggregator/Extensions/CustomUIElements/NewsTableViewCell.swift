//
//  NewsTableViewCell.swift
//  News Aggregator
//
//  Created by Igor on 28.06.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
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
        imageView.layer.cornerRadius = ConstraintConstants.textFieldCornerRadius
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
    
    public func configure(with news: UniqueNewsModel, index: Int) {
        self.titleLabel.text = news.title
        self.descriptionLabel.text = news.description
        self.creatorLabel.text = news.creator?.first
        self.pubDateLabel.text = news.pubDate?.formattedDate()
        setupPreview(with: news, index: index)
    }
    
    private func setupPreview(with news: UniqueNewsModel, index: Int) {
        if let data = news.imageData {
            self.previewImageView.image = UIImage(data: data)
        }
        else if let urlString = news.imageURL {
            
            guard let url = URL(string: urlString) else {
                return
            }
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data,
                        error == nil,
                        let newsImage = UIImage(data: data) else {
                    return
                }
                self?.viewModel?.newsArray?.results[index].imageData = data
                
                DispatchQueue.main.async {
                    self?.previewImageView.image = newsImage
                }
            }.resume()
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
                .inset(ConstraintConstants.labelDefaultHeight)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(ConstraintConstants.smallOffset)
            make.left.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
        }
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
                .offset(ConstraintConstants.smallOffset)
            make.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.left.equalTo(descriptionLabel.snp.right)
                .offset(ConstraintConstants.smallOffset)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        pubDateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.bottom.equalToSuperview()
                .inset(ConstraintConstants.smallOffset)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
                .inset(ConstraintConstants.labelDefaultHeight)
            make.left.equalTo(pubDateLabel.snp.right)
                .offset(ConstraintConstants.smallOffset)
            make.bottom.equalToSuperview()
                .inset(ConstraintConstants.smallOffset)
        }
    }
}
