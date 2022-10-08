//
//  SuccessViewController.swift
//  mock_project
//
//  Created by Le on 05/10/2022.
//

import UIKit

class SuccessViewController: UIViewController {
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var nextViewButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = view.applyGradient()
        nextViewButton?.setBorder(2, .white)
        nextViewButton?.cardShadow()
        nextViewButton?.backgroundColor = .primaryColor
        nextViewButton?.layer.cornerRadius = 15
    }

    @IBAction func didTapLoginView(_ sender: Any) {
        let loginVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginVc.modalPresentationStyle = .fullScreen
        self.present(loginVc, animated: true, completion: nil)
    }
    
    func didSetUserName(_ userName: String) {
        print("user \(userName)")
        DispatchQueue.main.async { [weak self] in
            self?.nameLabel?.text = userName
        }
    }
}
