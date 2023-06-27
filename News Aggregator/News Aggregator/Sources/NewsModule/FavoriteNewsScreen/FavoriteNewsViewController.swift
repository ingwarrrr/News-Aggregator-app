//
//  FavoriteNewsViewController.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import UIKit
import SnapKit

class FavoriteNewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        title = "Fav news"
        view.backgroundColor = .lightGray
    }
    
    private func setupHierarchy() {
        
    }
    
    private func setupLayout() {
        
    }
}
