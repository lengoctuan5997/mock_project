//
//  HomeInstance.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 02/10/2022.
//

import Foundation

enum TableCellStyle: Int {
    case categories = 0
    case favorite
    case library
}

enum LibraryCellStyle: Int {
    case petHeath = 0
    case myPet
    case handBook
    case training
}
struct LibrariesContent {
    let title: String
    let image: String
}
