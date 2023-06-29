//
//  NewsDetailViewController.swift
//  News Aggregator
//
//  Created by Igor on 28.06.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {
    var news: UniqueNewsModel
    
    private lazy var accountDetailView: NewsDetailView = {
        let detailView = NewsDetailView()
        detailView.setupDetailView(with: news)
        return detailView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
    }
    
    init(news: UniqueNewsModel) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubviews([
            accountDetailView
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: Fonts.regularOfSize16
        ]
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = StringConstants.navigationBarTitleText
        
    }
    
    private func setupLayout() {
        accountDetailView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
    }
}
