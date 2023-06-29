//
//  ViewController.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var viewModel: NewsFeedViewModelType
    var currentPage : Int = 0
    var isLoadingList : Bool = false
    
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
        viewModel.getNewsData(for: nil)
    }
    
    private func setupView() {
        title = StringConstants.newsTabBarText
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
    
    private func bindWithViewModel() {
        viewModel.getNewsSuccess = { [weak self] news in
            DispatchQueue.main.async {
                self?.newsTableView.reloadData()
                self?.isLoadingList = false
            }
        }
        
        viewModel.getNewsFailure = { error in
            print(error.localizedDescription)
        }
    }
    
    private func loadMoreItemsForList(){
        guard let nextPage = viewModel.newsModel?.last?.nextPage else {
            return
        }
        viewModel.getNewsData(for: nextPage)
    }
}


// MARK: - News UITableViewDataSource

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel.newsArray?.count else {
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
            let singleNews = viewModel.newsArray?[indexPath.row]
        else {
            return UITableViewCell()
        }
        
        cell.sizeToFit()
        cell.viewModel = viewModel
        cell.configure(with: singleNews, index: indexPath.row, type: .news)
        
        return cell
    }}

// MARK: - News UITableViewDelegate

extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return ConstraintConstants.tableViewHeight
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath
    ) {
        guard let singleNews = viewModel.newsArray?[indexPath.row] else {
            return
        }
        
        let detailVM = NewsDetailViewModel(news: singleNews)
        let detailVC = NewsDetailViewController(
            viewModel: detailVM,
            typeOfNews: .news
        )
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) >
             scrollView.contentSize.height ) && !isLoadingList) {
            isLoadingList = true
            loadMoreItemsForList()
        }
    }
}
