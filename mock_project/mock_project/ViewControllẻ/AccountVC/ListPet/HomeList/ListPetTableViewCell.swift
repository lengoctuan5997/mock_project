//
//  ListPetTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 05/10/2022.
//

import UIKit

class ListPetTableViewCell: UITableViewCell {
    @IBOutlet weak var speciesLabel: UILabel?
    @IBOutlet weak var petNameLabel: UILabel?
    @IBOutlet weak var petAvatar: UIImageView?
    @IBOutlet weak var container: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        petAvatar?.layer.cornerRadius = (petAvatar?.bounds.width ?? 0) / 2
        container?.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
