//
//  LoginViewController.swift
//  mock_project
//
//  Created by Le on 04/10/2022.
//

import UIKit
//import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?

    @IBOutlet weak var validationEmailLabel: UILabel!
    @IBOutlet weak var validationPasswordLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        validationEmailLabel.isHidden = true
        validationPasswordLabel.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        checkUserInfo()
    }

    @IBAction func didTapLogin(_ sender: Any) {
        validateFields()
    }

    @IBAction func didTapRegister(_ sender: Any) {
        let signUpVC = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        signUpVC.modalPresentationStyle = .fullScreen
        self.present(signUpVC, animated: true, completion: nil)
    }

    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTextField?.text {
            if let errorMessage = invalidEmail(email) {
                validationEmailLabel.text = errorMessage
                validationEmailLabel.isHidden = false
            } else {
                validationEmailLabel.isHidden = true
            }
        }
    }

    func invalidEmail(_ value: String) -> String? {
        if value.isEmpty == true {
            return "Không được để trống thông tin này"
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: value) {
            return "Email không hợp lệ"
        }
        return nil
    }

    @IBAction func passwordChanged(_ sender: Any) {
    }
    
    func validateFields() {
        if emailTextField?.text?.isEmpty == true {
            return
        }
        if passwordTextField?.text?.isEmpty == true {
            return
        }
        login()
    }

    func login() {
//        Auth.auth().signIn(withEmail: emailTextField?.text ?? "",
//            password: passwordTextField?.text ?? "") { (authResult, error) in
//            if let errorCreate = error {
//                  let err = errorCreate as NSError
//                  switch err.code {
//                  case AuthErrorCode.wrongPassword.rawValue:
//                      self.validationPasswordLabel.text = "Password không chính xác"
//                      self.validationPasswordLabel.isHidden = false
//                  default:
//                     print("unknown error: \(err.localizedDescription)")
//                  }
//               } else {
//                   let tabbarVC = TabbarController(nibName: "TabbarController", bundle: nil)
//                   tabbarVC.modalPresentationStyle = .fullScreen
//                   self.present(tabbarVC, animated: true, completion: nil)
//               }
//            }
        checkUserInfo()
    }

    func checkUserInfo() {
//        if Auth.auth().currentUser != nil {
//            let tabbarVC = TabbarController(nibName: "TabbarController", bundle: nil)
//            tabbarVC.modalPresentationStyle = .fullScreen
//            self.present(tabbarVC, animated: true, completion: nil)
//        }
    }
}
