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
    static var primaryColor: UIColor {
        #colorLiteral(red: 0.3429558873, green: 0.2553575635, blue: 0.6170496941, alpha: 1)
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

    func setBorder(
        _ width: CGFloat,
        _ color: UIColor
    ) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }

    func setStyleBackButton() {
        self.setBorder(2, .white)
        self.cardShadow()
        self.layer.cornerRadius = self.bounds.width / 2
        self.backgroundColor = .primaryColor
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

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Notification.Name {
    static let notiFicationNameList: Notification.Name = Notification.Name("tabBar.List")

    static let notiFicationNameHandBook: Notification.Name = Notification.Name("tabBar.handBook")
}

extension UITextField {
    func paddingLeft() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setTextFieldStyle() {
        self.paddingLeft()
        self.cardShadow()
        self.layer.cornerRadius = 15
        self.setBorder(1, .primaryColor)
    }
}
