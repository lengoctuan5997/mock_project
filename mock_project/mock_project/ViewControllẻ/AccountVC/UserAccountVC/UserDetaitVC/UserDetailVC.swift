//
//  UserDetailVC.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 07/10/2022.
//

import UIKit

class UserDetailVC: UIViewController {
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var phoneTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var addButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    @IBAction func didTapBackToPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapSaveInfo(_ sender: Any) {
    }
}

// MARK: - CONFIG UI
extension UserDetailVC {
    func configUI() {
        _ = view.applyGradient()
        tabBarController?.tabBar.isHidden = true
        userImage?.layer.cornerRadius = (userImage?.bounds.width ?? 0) / 2
        userImage?.cardShadow()

        nameTextField?.cardShadow()
        nameTextField?.paddingLeft()
        nameTextField?.setBorder(1, .primaryColor)
        nameTextField?.layer.cornerRadius = 15

        phoneTextField?.cardShadow()
        phoneTextField?.paddingLeft()
        phoneTextField?.setBorder(1, .primaryColor)
        phoneTextField?.layer.cornerRadius = 15

        emailTextField?.cardShadow()
        emailTextField?.paddingLeft()
        emailTextField?.setBorder(1, .primaryColor)
        emailTextField?.layer.cornerRadius = 15
        
        backButton?.setStyleBackButton()
        addButton?.setStyleBackButton()
    }
}
