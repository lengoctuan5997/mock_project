//
//  FavoriteCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 04/10/2022.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var animalImage: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView?.layer.cornerRadius = 10
        animalImage?.layer.cornerRadius = 10
//        containerView?.layer.masksToBounds = true
        containerView?.cardShadow()
    }

    override func prepareForReuse() {
        animalImage = nil
    }

}

extension FavoriteCell {
    func configData(_ imageName: String) {
        animalImage?.image = UIImage(named: imageName)
    }
}
