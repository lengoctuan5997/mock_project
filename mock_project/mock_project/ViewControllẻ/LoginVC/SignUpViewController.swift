//
//  SignUpViewController.swift
//  mock_project
//
//  Created by Le on 04/10/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var fullNameTextField: UITextField?
    @IBOutlet weak var phoneTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var confirmPasswordTextField: UITextField?

    @IBOutlet weak var validationNameLabel: UILabel!
    @IBOutlet weak var validationPhoneLabel: UILabel!
    @IBOutlet weak var validationEmailLabel: UILabel!
    @IBOutlet weak var validationPassword: UILabel!
    @IBOutlet weak var validationConfirmPassLabel: UILabel!

    @IBOutlet weak var submitFormButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetForm()
        configUI()
    }

    @IBAction func didTapSignUp(_ sender: Any) {
        signUp()
    }

    @IBAction func didTapLogin(_ sender: Any) {
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }

    func validationSignUp() {
        if passwordTextField?.text == confirmPasswordTextField?.text {
            return
        } else {
            validationConfirmPassLabel.text = "Mật khẩu không chính xác"
            validationConfirmPassLabel.isHidden = false
        }
    }

    @IBAction func fullNameChanged(_ sender: Any) {
        if let fullName = fullNameTextField?.text {
            if let errorMessage = invalidFullName(fullName) {
                validationNameLabel.text = errorMessage
                validationNameLabel.isHidden = false
            } else {
                validationNameLabel.isHidden = true
            }
        }
        checkValidForm()
    }

    func invalidFullName(_ value: String) -> String? {
        if value.isEmpty == true {
            return "Không được để trống thông tin này"
        }
        return nil
    }

    @IBAction func phoneChanged(_ sender: Any) {
        if let phoneNumber = phoneTextField?.text {
            if let errorMessage = invalidPhoneNumber(phoneNumber) {
                validationPhoneLabel.text = errorMessage
                validationPhoneLabel.isHidden = false
            } else {
                validationPhoneLabel.isHidden = true
            }
        }
        checkValidForm()
    }

    func invalidPhoneNumber(_ value: String) -> String? {
        let set = CharacterSet(charactersIn: value)
        if value.isEmpty == true {
            return "Không được để trống thông tin này"
        }
        if !CharacterSet.decimalDigits.isSuperset(of: set) {
           return "Số điện thoại không hợp lệ"
        }
        if value.count !=  10 {
            return "Số điện thoại phải 10 số"
        }
        return nil
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
        checkValidForm()
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
        if let password = passwordTextField?.text {
            if let errorMessage = invalidPassword(password) {
                validationPassword.text = errorMessage
                validationPassword.isHidden = false
            } else {
                validationPassword.isHidden = true
            }
        }
        checkValidForm()
    }

    func invalidPassword(_ value: String) -> String? {
        if value.isEmpty == true {
            return "Không được để trống thông tin này"
        }
        if value.count < 8 {
            return "Mật khẩu có ít nhất 8 kí tự"
        }
        if containDigit(value) {
            return  "Mật khẩu có ít nhất 1 số"
        }
        if containUppercase(value) {
            return "Mật khẩu phải có 1 kí tự in hoa"
        }
        return nil
    }

    func containDigit(_ value: String) -> Bool {
        let regular = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        return !predicate.evaluate(with: value)
    }

    func containUppercase(_ value: String) -> Bool {
        let regular = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regular)
        return !predicate.evaluate(with: value)
    }

    @IBAction func confirmPasswordChanged(_ sender: Any) {
        if let confirmPassword = confirmPasswordTextField?.text {
            if let errorMessage = invalidConfirmPassword(confirmPassword) {
                validationConfirmPassLabel.text = errorMessage
                validationConfirmPassLabel.isHidden = false
            } else {
                validationConfirmPassLabel.isHidden = true
            }
        }
        checkValidForm()
    }

    func invalidConfirmPassword(_ value: String) -> String? {
        if value != passwordTextField?.text {
            return "Mật khẩu không chính xác"
        }
        return nil
    }

    func checkValidForm() {
        if validationNameLabel.isHidden && validationPhoneLabel.isHidden &&
            validationEmailLabel.isHidden && validationPassword.isHidden && validationConfirmPassLabel.isHidden {
            submitFormButton.isEnabled = true
            submitFormButton.backgroundColor = .primaryColor
        } else {
            submitFormButton.isEnabled = false
            submitFormButton.backgroundColor = .gray
        }
    }

    func signUp() {
        resetForm()
        let email = emailTextField?.text ?? ""
        let password = passwordTextField?.text ?? ""
        let fullName = fullNameTextField?.text ?? ""
        let phoneNumber = phoneTextField?.text ?? ""
        Auth.auth().createUser(
            withEmail: email,
            password: password
        ) { (authResult, error) in
            if let errorCreate = error {
              let err = errorCreate as NSError
              switch err.code {
              case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                 print("accountExistsWithDifferentCredential")
              case AuthErrorCode.emailAlreadyInUse.rawValue:
                  self.validationEmailLabel.text = "Email đã tồn tại"
                  self.validationEmailLabel.isHidden = false
              default:
                  let alert = UIAlertController(
                    title: "Warning",
                    message: "\(err.localizedDescription)",
                    preferredStyle: .alert
                  )

                  alert.addAction(UIAlertAction(title: "Close", style: .cancel))
                  self.present(alert, animated: true)
                 print("unknown error: \(err.localizedDescription)")
              }
           } else {
               let dbUser = Firestore.firestore()
               dbUser.collection("users").addDocument(data: [
                "uid": authResult?.user.uid ?? "",
                "fullName": fullName,
                "password": password,
                "email": email,
                "phoneNumber": phoneNumber,
                "isAdmin": false]
               ) {(error) in
                   if error != nil {
                       print("User not save")
                   }
               }
               let successVC = SuccessViewController(nibName: "SuccessViewController", bundle: nil)
               successVC.didSetUserName(fullName)
               successVC.modalPresentationStyle = .fullScreen
               self.present(successVC, animated: true, completion: nil)
           }
        }
    }
}

// MARK: - CONFIG
extension SignUpViewController {
    func configUI() {
        _ = view.applyGradient()
        fullNameTextField?.cardShadow()
        fullNameTextField?.paddingLeft()
        fullNameTextField?.layer.cornerRadius = 15
        fullNameTextField?.setBorder(1, .primaryColor)

        phoneTextField?.cardShadow()
        phoneTextField?.paddingLeft()
        phoneTextField?.layer.cornerRadius = 15
        phoneTextField?.setBorder(1, .primaryColor)

        emailTextField?.cardShadow()
        emailTextField?.paddingLeft()
        emailTextField?.layer.cornerRadius = 15
        emailTextField?.setBorder(1, .primaryColor)

        passwordTextField?.cardShadow()
        passwordTextField?.paddingLeft()
        passwordTextField?.layer.cornerRadius = 15
        passwordTextField?.setBorder(1, .primaryColor)

        confirmPasswordTextField?.cardShadow()
        confirmPasswordTextField?.paddingLeft()
        confirmPasswordTextField?.layer.cornerRadius = 15
        confirmPasswordTextField?.setBorder(1, .primaryColor)

        submitFormButton?.setBorder(1, .white)
    }

    func resetForm() {
        submitFormButton.isEnabled = false
        submitFormButton.backgroundColor = .gray

        validationNameLabel?.isHidden = true
        validationPhoneLabel?.isHidden = true
        validationEmailLabel?.isHidden = true
        validationPassword?.isHidden = true
        validationConfirmPassLabel?.isHidden = true

        validationNameLabel?.text = ""
        validationPhoneLabel?.text = ""
        validationEmailLabel?.text = ""
        validationPassword?.text = ""
        validationConfirmPassLabel?.text = ""
    }
}
