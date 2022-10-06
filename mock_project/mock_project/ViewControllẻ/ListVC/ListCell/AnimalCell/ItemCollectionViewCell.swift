//
//  ItemCollectionViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animalImageView: UIImageView?
    @IBOutlet weak var animalLabel: UILabel?
    @IBOutlet weak var animalContainerView: UIView?
    @IBOutlet weak var animailNameContent: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        animalContainerView?.cardShadow()
        animalContainerView?.layer.cornerRadius = 15
        animailNameContent?.layer.cornerRadius = 15
        animalImageView?.clipsToBounds = true
        animalImageView?.layer.cornerRadius = 15
    }
}
