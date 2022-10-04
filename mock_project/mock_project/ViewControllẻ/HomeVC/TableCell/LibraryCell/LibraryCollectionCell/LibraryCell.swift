//
//  LibraryCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 02/10/2022.
//

import UIKit

class LibraryCell: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView?
    @IBOutlet weak var nameView: UIView?
    @IBOutlet weak var animalImage: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?

    var handBookClousure: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView?.cardShadow()
        nameView?.cardShadow()
        nameView?.layer.cornerRadius = 15
        cellView?.layer.cornerRadius = 15
        animalImage?.layer.cornerRadius = 15

        animalImage?.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapNavToHandBookView)
            )
        )
    }

    @objc
    func didTapNavToHandBookView(_ gesture: UITapGestureRecognizer) {
        handBookClousure()
    }

}

extension LibraryCell {
    func configUIData(_ name: String) {
        animalImage?.image = UIImage(named: name)
    }
}
