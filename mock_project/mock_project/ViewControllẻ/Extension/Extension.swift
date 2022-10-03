//
//  Extension.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

extension UIColor {
    static var tabBarItemAccent: UIColor {
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    static var tabBarColor: UIColor {
        #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.5)
    }
    static var tabBarItemLight: UIColor {
        #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    }
}

extension UIView {
    func cardShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
    }
}

extension Notification.Name {
    static let notiFicationNameList: Notification.Name = Notification.Name("tabBar.List")

    static let notiFicationNameHandBook: Notification.Name = Notification.Name("tabBar.handBook")
}
