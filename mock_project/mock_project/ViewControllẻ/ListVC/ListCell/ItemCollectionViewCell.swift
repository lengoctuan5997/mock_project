//
//  ItemCollectionViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView?
    @IBOutlet weak var itemLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        itemImageView?.clipsToBounds = true
        itemImageView?.layer.cornerRadius = 20
        itemImageView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
