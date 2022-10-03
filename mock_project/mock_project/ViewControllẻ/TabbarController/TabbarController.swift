//
//  TabbarController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initTabbar()
        customTabbarAppearance()
    }

    func selectedTabIndex(_ index: Int) {
        tabBarController?.selectedIndex = index
        self.selectedIndex = index
    }

}
// MARK: - init navigation controller
extension TabbarController {
    func initTabbar() {
        let homeVC = generateNavController(
            HomeViewController(),
            "",
            "homekit"
        )
        let listVC = generateNavController(
            ListViewController(),
            "",
            "list.dash"
        )
        let accountVC = generateNavController(
            AccountViewController(),
            "",
            "person.fill"
        )

//        UINavigationBar.appearance().prefersLargeTitles = true
        viewControllers = [homeVC, listVC, accountVC]
    }

    func generateNavController(
        _ viewController: UIViewController,
        _ title: String,
        _ navImage: String
    ) -> UINavigationController {
        viewController.navigationItem.title = title

        let navController = UINavigationController(
            rootViewController: viewController
        )
        navController.title = title
        navController.tabBarItem.image = UIImage(systemName: navImage)
        return navController
    }

    // style tabbar
    func customTabbarAppearance() {
        let positionX: CGFloat = 10
        let positionY: CGFloat = 20

        let width = tabBar.bounds.width - positionX * 2
        let height = tabBar.bounds.height + positionY * 1.3

        let roundLayer = CAShapeLayer()

        let beziePath = UIBezierPath(
            roundedRect: CGRect(
                x: positionX,
                y: tabBar.bounds.minY - positionY  / 2 - 10,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )

        roundLayer.path = beziePath.cgPath
        roundLayer.fillColor = UIColor.tabBarItemAccent.cgColor

        tabBar.layer.insertSublayer(roundLayer, at: 0)

        tabBar.itemWidth = width / 3
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .tabBarItemLight
        tabBar.unselectedItemTintColor = .tabBarColor
        tabBar.cardShadow()
    }
}
