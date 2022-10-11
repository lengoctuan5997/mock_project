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
    
    var unsaveFavoriteClousure: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView?.layer.cornerRadius = 10
        animalImage?.layer.cornerRadius = 10
        containerView?.cardShadow()
    }

    override func prepareForReuse() {
        animalImage = nil
    }

    @IBAction func didTapUnsaveFavorite(_ sender: Any) {
        unsaveFavoriteClousure()
    }
}

extension FavoriteCell {
    func configData(_ imageData: Data) {
        let image = UIImage(data: imageData)
        animalImage?.image = image
    }
}
