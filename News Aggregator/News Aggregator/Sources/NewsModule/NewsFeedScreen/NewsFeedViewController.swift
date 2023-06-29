//
//  ViewController.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var viewModel: NewsFeedViewModelType
    
    private lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self,
            forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    init(viewModel: NewsFeedViewModelType) {
        self.viewModel = viewModel
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
        bindWithViewModel()
        viewModel.getNewsData()
    }
    
    private func setupView() {
        title = "News"
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubviews([
            newsTableView
        ])
    }
    
    private func setupLayout() {
        newsTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bindWithViewModel() {
        viewModel.getNewsSuccess = { [weak self] news in
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
            }
        }
        
        viewModel.getNewsFailure = { [weak self] error in
            print(error.localizedDescription)
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
            }
        }
    }
}


// MARK: - News UITableViewDataSource

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel.newsArray?.results.count else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? NewsTableViewCell,
            let singleNews = viewModel.newsArray?.results[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.sizeToFit()
        cell.viewModel = viewModel
        cell.configure(with: singleNews, index: indexPath.row)
        
        return cell
    }}

// MARK: - News UITableViewDelegate

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let singleNews = viewModel.newsArray?.results[indexPath.row] else {
            return
        }
        
        let detailVC = NewsDetailViewController(news: singleNews)
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
