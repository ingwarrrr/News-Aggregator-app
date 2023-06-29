//
//  FavoriteNewsViewController.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import UIKit
import SnapKit

class FavoriteNewsViewController: UIViewController {
    var viewModel: FavoriteNewsViewModelType
    
    private lazy var favNewsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self,
            forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    init(viewModel: FavoriteNewsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favNewsTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        title = StringConstants.favNewsTabBarText
        view.backgroundColor = .white
    }
    
    private func setupHierarchy() {
        view.addSubviews([
            favNewsTableView
        ])
    }
    
    private func setupLayout() {
        favNewsTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - News UITableViewDataSource

extension FavoriteNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.favNewsArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? NewsTableViewCell
        else {
            return UITableViewCell()
        }
        let singleNews = viewModel.favNewsArray[indexPath.row]
        cell.sizeToFit()
        cell.configure(
            with: singleNews,
            index: indexPath.row,
            type: .favNews
        )
        
        return cell
    }}

// MARK: - News UITableViewDelegate

extension FavoriteNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        ConstraintConstants.tableViewHeight
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let singleNews = viewModel.favNewsArray[indexPath.row]
        
        let detailVM = NewsDetailViewModel(news: singleNews)
        let detailVC = NewsDetailViewController(
            viewModel: detailVM,
            typeOfNews: .favNews
        )
        detailVC.indexImage = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
