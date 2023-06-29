//
//  NewsDetailComponent.swift
//  News Aggregator
//
//  Created by Igor on 28.06.2023.
//

import UIKit

class NewsDetailComponent: UIView {
    enum NewsLabelType {
        case title
        case description
        case creator
        case pubDate
        case link
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regularOfSize15
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.mediumOfSize16
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private let labelType: NewsLabelType
    
    init(_ labelType: NewsLabelType) {
        self.labelType = labelType
        super.init(frame: .zero)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupViews() {
        switch labelType {
        case .title:
            titleLabel.text = StringConstants.titleText
        case .description:
            titleLabel.text = StringConstants.descriptionText
        case .creator:
            titleLabel.text = StringConstants.creatorText
        case .pubDate:
            titleLabel.text = StringConstants.publicationDate
        case .link:
            titleLabel.text = StringConstants.linkText
        }
    }
    
    private func setupHierarchy() {
        self.addSubviews([
            titleLabel,
            contentLabel
        ])
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(ConstraintConstants.labelDefaultHeight)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


