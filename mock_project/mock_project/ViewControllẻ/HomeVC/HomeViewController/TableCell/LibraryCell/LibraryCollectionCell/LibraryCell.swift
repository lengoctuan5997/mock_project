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
    @IBOutlet weak var imageView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }
}
// MARK: - CONFIG UI
extension LibraryCell {
    func configUI() {
        cellView?.cardShadow()
        nameView?.cardShadow()
        nameView?.layer.cornerRadius = 15
        cellView?.layer.cornerRadius = 15
        imageView?.layer.cornerRadius = 15
        nameView?.setBorder(2, .white)
    }
}

extension LibraryCell {
    func configUIData(_ libra: LibrariesContent) {
        animalImage?.image = UIImage(named: libra.image)
        nameLabel?.text = libra.title
    }
}
