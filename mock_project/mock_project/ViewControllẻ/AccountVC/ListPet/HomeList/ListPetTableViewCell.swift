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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
