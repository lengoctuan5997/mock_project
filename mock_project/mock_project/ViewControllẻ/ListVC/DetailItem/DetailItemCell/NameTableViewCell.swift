//
//  NameTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var heartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton.layer.cornerRadius = 25
        heartButton.setImage(
            UIImage(systemName: "heart.fill")?.withTintColor(
                        .black,
                        renderingMode: .alwaysOriginal
                    ),
            for: .normal
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
