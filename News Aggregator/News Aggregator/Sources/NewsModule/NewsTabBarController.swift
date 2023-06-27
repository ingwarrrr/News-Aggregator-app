//
//  NewsTabBarController.swift
//  News Aggregator
//
//  Created by Igor on 27.06.2023.
//

import UIKit

fileprivate enum Constants {
    static let tabBarShadowOffset = 0
    static let tabBarShadowRadius: CGFloat = 10
    static let tabBarShadowOpacity: Float = 0.15
}

class NewsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarViewShadow()
        setupTabBarAppearance()
    }
    
    public func setupTabBarItems() {
        let newsVM = NewsFeedViewModel()
        let newsVC = NewsFeedViewController(viewModel: newsVM)
        let newsNC = UINavigationController(rootViewController: newsVC)
        newsNC.tabBarItem = configureTabBarItem(
            with: "News",
            and: "tabBarItemNews"
        )
        
        let favoriteNewsVC = FavoriteNewsViewController()
        let favoriteNewsNC = UINavigationController(rootViewController: favoriteNewsVC)
        favoriteNewsNC.tabBarItem = configureTabBarItem(
            with: "Fav news",
            and: "tabBarItemFavs"
        )
        
        self.viewControllers = [newsNC, favoriteNewsNC]
        self.selectedIndex = 0
    }
    
    private func setupTabBarViewShadow() {
        tabBar.backgroundColor = .white
        tabBar.layer.shadowOffset = CGSize(
            width: Constants.tabBarShadowOffset,
            height: Constants.tabBarShadowOffset
        )
        tabBar.layer.shadowRadius = Constants.tabBarShadowRadius
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = Constants.tabBarShadowOpacity
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:
                            UIFont.systemFont(ofSize: 13, weight: .regular)]
        appearance.setTitleTextAttributes(
            attributes,
            for: []
        )
        tabBar.tintColor = .systemBlue
    }
    
    private func configureTabBarItem(
        with title: String,
        and imageName: String
    ) -> UITabBarItem {
        UITabBarItem(
            title: title,
            image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: imageName)
        )
    }
}
