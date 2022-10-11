//
//  LoginViewController.swift
//  mock_project
//
//  Created by Le on 04/10/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var validationEmailLabel: UILabel?
    @IBOutlet weak var validationPasswordLabel: UILabel?
    @IBOutlet weak var signinButton: UIButton!

    var userManager = UserManager.shared
    let authen = Auth.auth()
    private let loadingView: LoadingView = {
        let loadingView = LoadingView(
            nibName: "LoadingView",
            bundle: .main
        )

        loadingView.modalPresentationStyle = .overCurrentContext
        loadingView.modalTransitionStyle = .crossDissolve

        return loadingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        validationEmailLabel?.isHidden = true
        validationPasswordLabel?.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        onCheckUserIsLogin()
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
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
                validationEmailLabel?.text = errorMessage
                validationEmailLabel?.isHidden = false
            } else {
                validationEmailLabel?.isHidden = true
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

}
// MARK: - config UI
extension LoginViewController {
    func configUI() {
        self.setupToHideKeyboardOnTapOnView()
        _ = view.applyGradient()

        emailTextField?.cardShadow()
        emailTextField?.paddingLeft()
        emailTextField?.setBorder(1, .primaryColor)

        passwordTextField?.cardShadow()
        passwordTextField?.paddingLeft()
        passwordTextField?.setBorder(1, .primaryColor)

        emailTextField?.layer.cornerRadius = 15
        passwordTextField?.layer.cornerRadius = 15

        signinButton.setBorder(1, .white)
        signinButton.cardShadow()

    }
}

// MARK: - login
extension LoginViewController {
    func login() {

        self.present(loadingView, animated: true)

        authen.signIn(
            withEmail: emailTextField?.text ?? "",
            password: passwordTextField?.text ?? ""
        ) { [weak self] (_, error) in
            if let errorCreate = error {
              let err = errorCreate as NSError
              switch err.code {
              case AuthErrorCode.wrongPassword.rawValue:
                  self?.validationPasswordLabel?.text = "Password không chính xác"
                  self?.validationPasswordLabel?.isHidden = false
              default:
                  let alert = UIAlertController(
                    title: "Warning",
                    message: "\(err.localizedDescription)",
                    preferredStyle: .alert
                  )

                  alert.addAction(UIAlertAction(title: "Close", style: .cancel))
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      self?.present(alert, animated: true)
                  }
              }
                self?.loadingView.didDismissView()
           } else {
               self?.onCheckUserIsLogin()
           }
        }
    }

    private func onCheckUserIsLogin() {
        if authen.currentUser != nil {
//            onGetCurrentUserLogin()
            
            let id = authen.currentUser?.uid
            Firestore.firestore().collection("users").getDocuments { [weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents
                    where id == document["uid"] as? String {
                        guard let fullName = document["fullName"] as? String else {
                            return
                        }
                        guard let phoneNumber = document["phoneNumber"] as? String else {
                            return
                        }
                        guard let isAdmin = document["isAdmin"] as? Bool else {
                            return
                        }
                        guard let password = document["password"] as? String else {
                            return
                        }
                        guard let uid = document["uid"] as? String else {
                            return
                        }
                        guard let email = document["email"] as? String else {
                            return
                        }
                        
                        let storage = Storage.storage().reference().child("user_avatar/\(uid).jpg")

                        storage.getData(maxSize: 15 * 1024 * 1024) { data, error in
                            if error != nil {
                                print(error?.localizedDescription ?? "errror")
                            } else {
                                let image = UIImage(data: data ?? Data())
                                let user = User(
                                    fullName: fullName,
                                    phoneNumber: phoneNumber,
                                    isAdmin: isAdmin,
                                    password: password,
                                    uid: uid,
                                    email: email,
                                    image: image
                                )

                                DispatchQueue.main.async {
                                    self?.userManager.setUserInfo(user)
                                    self?.loadingView.didDismissView()
                                }

                                let tabbarVC = TabbarController(
                                    nibName: "TabbarController",
                                    bundle: nil
                                )
                                tabbarVC.modalPresentationStyle = .fullScreen
                                self?.present(
                                    tabbarVC,
                                    animated: true,
                                    completion: nil
                                )
                            }
                        }

                    }
                }
            }
        }
    }

    private func onGetCurrentUserLogin() {
        let id = authen.currentUser?.uid
        Firestore.firestore().collection("users").getDocuments { [weak self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents
                where id == document["uid"] as? String {
                    guard let fullName = document["fullName"] as? String else {
                        return
                    }
                    guard let phoneNumber = document["phoneNumber"] as? String else {
                        return
                    }
                    guard let isAdmin = document["isAdmin"] as? Bool else {
                        return
                    }
                    guard let password = document["password"] as? String else {
                        return
                    }
                    guard let uid = document["uid"] as? String else {
                        return
                    }
                    guard let email = document["email"] as? String else {
                        return
                    }
                    
                    let storage = Storage.storage().reference().child("user_avatar/\(uid).jpg")

                    storage.getData(maxSize: 15 * 1024 * 1024) { data, error in
                        if error != nil {
                            print(error?.localizedDescription ?? "errror")
                        } else {
                            let image = UIImage(data: data ?? Data())
                            let user = User(
                                fullName: fullName,
                                phoneNumber: phoneNumber,
                                isAdmin: isAdmin,
                                password: password,
                                uid: uid,
                                email: email,
                                image: image
                            )
                            DispatchQueue.main.async {
                                self?.userManager.setUserInfo(user)
                            }
                        }
                    }

                }
            }
        }
    }
}
