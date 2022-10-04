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
    @IBOutlet weak var heartButton: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        animalNameView?.layer.cornerRadius = 15
        animalNameView?.cardShadow()
        cellView?.cardShadow()
        cellView?.layer.cornerRadius = 15
        animalsImage?.layer.cornerRadius = 15
        heartButton?.layer.cornerRadius = (heartButton?.bounds.size.width ?? 0) / 2
    }

    @IBAction func didTapAddFavorite(_ sender: Any) {
        heartButton?.tintColor = .red
    }

}

// MARK: - config UI
extension FavoriteCollectionCell {
    func configDataUI(
        _ name: String
    ) {
        animalName?.text = name
        animalsImage?.image = UIImage(named: name)
    }
}
