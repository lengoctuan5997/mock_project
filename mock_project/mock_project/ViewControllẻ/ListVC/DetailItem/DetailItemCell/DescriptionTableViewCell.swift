//
//  DescriptionTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var sexView: UIView!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var weightView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        sexView.clipsToBounds = true
        ageView.clipsToBounds = true
        weightView.clipsToBounds = true

        sexView.layer.cornerRadius = 25
        ageView.layer.cornerRadius = 25
        weightView.layer.cornerRadius = 25

        sexView.layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        ageView.layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        weightView.layer.maskedCorners = [.layerMinXMinYCorner,
                                          .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
