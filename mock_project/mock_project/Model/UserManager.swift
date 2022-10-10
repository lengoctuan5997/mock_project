//
//  UserManager.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 06/10/2022.
//

import Foundation

class UserManager {
    public static let shared = UserManager()
    var user: User = User()

    func setUserInfo(_ user: User) {
        self.user = user
    }

    func getUserInfo() -> User {
        return user
    }
}

struct User {
    var fullName: String?
    var phoneNumber: String?
    var isAdmin: Bool?
    var password: String?
    var uid: String?
    var email: String?
}
