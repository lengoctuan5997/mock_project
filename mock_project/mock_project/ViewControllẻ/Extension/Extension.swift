//
//  Extension.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

extension UIColor {
    static var tabBarItemAccent: UIColor {
        #colorLiteral(red: 0.9932342172, green: 0.9932342172, blue: 0.9932342172, alpha: 1)
    }
    static var tabBarColor: UIColor {
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7882346854)
    }
    static var tabBarItemLight: UIColor {
        #colorLiteral(red: 0.1132211015, green: 0.6089417934, blue: 0.9398133159, alpha: 1)
    }
}

extension UIView {
    func cardShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
    }

    func applyGradient(_ cornerRadius: CGFloat = 0) -> CAGradientLayer {
        let colours: [UIColor] = [
            .blue,
            .red,
            .orange
        ]
        return self.applyGradient(
            colours: colours,
            locations: nil,
            cornerRadius
        )
    }

    func applyGradient(
        colours: [UIColor],
        locations: [NSNumber]?,
        _ cornerRadius: CGFloat
    ) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.opacity = 0.2
        gradient.cornerRadius = cornerRadius
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(gradient, at: 0)

        return gradient
    }

    func setBorder() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
}

extension UIViewController {
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension Notification.Name {
    static let notiFicationNameList: Notification.Name = Notification.Name("tabBar.List")

    static let notiFicationNameHandBook: Notification.Name = Notification.Name("tabBar.handBook")
}
