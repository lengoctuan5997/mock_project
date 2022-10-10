//
//  HandBookPostCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 08/10/2022.
//

import UIKit

class HandBookPostCell: UITableViewCell {
    @IBOutlet weak var titleHandBook: UILabel?
    @IBOutlet weak var descriptionHandBook: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
//        descriptionHandBook?.lineBreakMode = .byWordWrapping
//        descriptionHandBook?.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        titleHandBook?.text = nil
        descriptionHandBook?.text = nil
    }
}

extension HandBookPostCell {
    func didSetData(_ handBook: HandBook) {
        titleHandBook?.text = handBook.title
        descriptionHandBook?.text = handBook.description
    }
}
