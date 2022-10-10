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

    @IBAction func didTapBackToPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapSaveInfo(_ sender: Any) {
        let db = Firestore.firestore()
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
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
                action: #selector(didTapAddImagePet)
            )
        )
        
        let user: User = userManager.getUserInfo()
        print("User \(user)")
        nameTextField?.text = user.fullName
        phoneTextField?.text = user.phoneNumber
        emailTextField?.text = user.email

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
                self.userImage?.image = image

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
    func didTapAddImagePet() {
        print("tap")
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    func updateFirestoreUserProfile(uid: String, data: [String: Any]) {
        Firestore.firestore().collection("users").document(uid).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err) ")
            } else {
                print("Document successfully updated")
            }
        }
    }
}

extension UserDetailVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
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

             ref.putData(imageData, metadata: md) { (metadata, error) in
                 if error == nil {
                     ref.downloadURL(completion: { (url, error) in
                         print("Done, url is \(String(describing: url))")
                     })
                     let data = [
                        "image": path
                     ]
                     self.updateFirestoreUserProfile(uid: "r6YYyxieUxivIk8x8ESr", data: data)
                 } else {
                     print("error \(String(describing: error))")
                 }
             }
        }
        picker.dismiss(animated: true)
    }
}
