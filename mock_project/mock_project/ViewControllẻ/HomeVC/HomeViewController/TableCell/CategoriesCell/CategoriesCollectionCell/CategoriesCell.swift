//
//  CategoriesCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 30/09/2022.
//

import UIKit

class CategoriesCell: UICollectionViewCell {
    @IBOutlet weak var animalsCell: UIImageView?
    @IBOutlet weak var animalsNameLabel: UILabel?
    @IBOutlet weak var contentNameView: UIView?
    @IBOutlet weak var categoriesView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentNameView?.layer.cornerRadius = 15
        categoriesView?.layer.cornerRadius = 15
        categoriesView?.cardShadow()
    }

    override func prepareForReuse() {
        animalsCell = nil
        animalsNameLabel = nil
    }
}

// MARK: - config data UI
extension CategoriesCell {
    func configData(
        _ name: String
    ) {
        animalsCell?.image = UIImage(named: name)
//        animalsNameLabel?.text = name.uppercased()
    }
}
