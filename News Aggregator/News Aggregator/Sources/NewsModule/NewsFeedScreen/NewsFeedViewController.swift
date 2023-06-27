//
//  ViewController.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    var viewModel: NewsFeedViewModelType
    
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
        viewModel.getNewsData()
        bindWithViewModel()
    }
    
    private func setupView() {
        title = "News"
        view.backgroundColor = .white
    }
    
    func bindWithViewModel() {
        viewModel.getNewsSuccess = { [weak self] news in
            print(news)
            DispatchQueue.main.async {
                
            }
        }
        
        viewModel.getNewsFailure = { [weak self] error in
            print(error.localizedDescription)
            DispatchQueue.main.async {
                
            }
        }
    }
}

