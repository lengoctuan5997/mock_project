//
//  FavoriteCollectionCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 30/09/2022.
//

import UIKit

class FavoriteCollectionCell: UICollectionViewCell {
    @IBOutlet weak var animalNameView: UIView?
    @IBOutlet weak var animalName: UILabel?
    @IBOutlet weak var animalsImage: UIImageView?
    @IBOutlet weak var cellView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        animalNameView?.layer.cornerRadius = 15
        animalNameView?.cardShadow()
        cellView?.cardShadow()
        cellView?.layer.cornerRadius = 15
        animalsImage?.layer.cornerRadius = 15
    }


    override func prepareForReuse() {
        animalsImage?.image = nil
    }
}

// MARK: - config UI
extension FavoriteCollectionCell {
    func configDataUI(
        _ imageData: Data
    ) {
        animalsImage?.image = UIImage(data: imageData)
    }
}
