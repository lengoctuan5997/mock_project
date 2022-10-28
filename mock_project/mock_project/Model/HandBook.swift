//
//  HandBook.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 08/10/2022.
//

import Foundation
import UIKit
import FirebaseFirestore

class HandBook: Codable {
    var animal: String?
    var description: String?
    var title: String = ""
    var image: String?
//    public static let shared = HandBook()
    private enum CodingKeys: String, CodingKey {
        case animal
        case description
        case title
        case image
    }
}
