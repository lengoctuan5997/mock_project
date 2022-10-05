//
//  HealthBookTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 04/10/2022.
//

import UIKit

class HealthBookTableViewCell: UITableViewCell {
    @IBOutlet weak var contentHealthBookLabel: UILabel?
    @IBOutlet weak var detailHealthBookLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
