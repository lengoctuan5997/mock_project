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
    
//    override var isHighlighted: Bool {
//        didSet {
//            print(isHighlighted)
//            let color = #colorLiteral(red: 0.3429558873, green: 0.2553575635, blue: 0.6170496941, alpha: 1)
//            if self.isHighlighted {
//                categoriesView?.layer.borderColor = UIColor.cyan.cgColor
//                categoriesView?.layer.borderWidth = 2
//            } else {
//                categoriesView?.layer.borderColor = nil
//                categoriesView?.layer.borderWidth = 0
//            }
//        }
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let color = #colorLiteral(red: 0.3429558873, green: 0.2553575635, blue: 0.6170496941, alpha: 1)
        contentNameView?.layer.cornerRadius = 15
        categoriesView?.layer.cornerRadius = 15
        categoriesView?.cardShadow()
        categoriesView?.setBorder(2, color)
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
