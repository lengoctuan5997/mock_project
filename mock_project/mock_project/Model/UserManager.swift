//
//  UserManager.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 06/10/2022.
//

import Foundation
import UIKit

class UserManager {
    public static let shared = UserManager()
    var user: User = User()

    func setUserInfo(_ user: User) {
        self.user = user
    }

    func getUserInfo() -> User {
        return user
    }
    
    func setUserImage(_ image: UIImage) {
        self.user.image = image
    }
}

struct User {
    var fullName: String?
    var phoneNumber: String?
    var isAdmin: Bool?
    var password: String?
    var uid: String?
    var email: String?
    var image: UIImage?
}
