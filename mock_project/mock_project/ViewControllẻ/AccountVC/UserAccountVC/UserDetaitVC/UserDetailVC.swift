//
//  UserDetailVC.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 07/10/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class UserDetailVC: UIViewController {
    @IBOutlet weak var userImage: UIImageView?
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var phoneTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var addButton: UIButton?

    private let userManager = UserManager.shared
    private let storage = Storage.storage().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("destroy")
        onGetCurrentUserLogin()
    }

    @IBAction func didTapBackToPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapSaveInfo(_ sender: Any) {
        guard let name = self.nameTextField?.text else {
            return
        }
        guard let phone = self.phoneTextField?.text else {
            return
        }
        guard let email = self.emailTextField?.text else {
            return
        }

        let data = [
           "fullName": name,
           "phoneNumber": phone,
           "email": email
        ]
        updateFirestoreUserProfile(uid: "r6YYyxieUxivIk8x8ESr", data: data)
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

        userImage?.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapAddUserImage)
            )
        )

        let user: User = userManager.getUserInfo()
        nameTextField?.text = user.fullName
        phoneTextField?.text = user.phoneNumber
        emailTextField?.text = user.email
        userImage?.image = user.image
    }

    private func getUserImage() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Handle Error")
            return
        }

        let storage = Storage.storage().reference().child("user_avatar/\(uid).jpg")

        storage.getData(maxSize: 15 * 1024 * 1024) { data, error in
            if error != nil {
                print(error?.localizedDescription ?? "errror")
            } else {
                let image = UIImage(data: data!)

                DispatchQueue.main.async {
                    self.userImage?.image = image
                }

                storage.downloadURL { url, error in
                    if error != nil {
                        print(error?.localizedDescription ?? "error")
                    } else {
                        print(url ?? "url")
                    }
                }
            }
        }
    }

    @objc
    func didTapAddUserImage() {
        print("tap")
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    func updateFirestoreUserProfile(uid: String, data: [String: Any]) {
        Firestore.firestore().collection("users").document(uid).updateData(data) { [weak self] err in
            if let err = err {
                print("Error updating document: \(err) ")
            } else {
                print("Document successfully updated")
            }
            self?.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(
                name: NSNotification.Name.notiFicationNameUser, 
                object: nil
            )
        }
    }
}

extension UserDetailVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func imagePickerController(
        _ picker: UIImagePickerController,
       didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let im: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage,
           let imageData = im.pngData() {
            userImage?.image = im
            let md = StorageMetadata()
            md.contentType = "image/png"
            guard let uid = Auth.auth().currentUser?.uid else {
                print("Handle Error")
                return
            }
            let path = "user_avatar/\(uid).jpg"
            let ref = Storage.storage().reference().child(path)

             ref.putData(imageData, metadata: md) { [weak self] (metadata, error) in
                 if error == nil {
                     ref.downloadURL(completion: { (url, error) in
                         print("Done, url is \(String(describing: url))")
                     })
                     let data = [
                        "image": path
                     ]
                     self?.updateFirestoreUserProfile(uid: "r6YYyxieUxivIk8x8ESr", data: data)
                 } else {
                     print("error \(String(describing: error))")
                 }
             }
        }
        picker.dismiss(animated: true)
    }
    
    private func onGetCurrentUserLogin() {
        let id = Auth.auth().currentUser?.uid
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
