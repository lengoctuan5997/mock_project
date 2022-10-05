//
//  InformationTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 03/10/2022.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
