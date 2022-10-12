//
//  AddAvatarPetTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 05/10/2022.
//

import UIKit

class AddAvatarPetTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarPet: UIImageView?
    var pickerClosure: () -> () = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarPet?.layer.cornerRadius = (avatarPet?.frame.height ?? 100) / 2
    }
}

extension AddAvatarPetTableViewCell {
    @IBAction func didTapAddPhotoPet(_ sender: Any) {
      pickerClosure()
    }
}
