//
//  InformationTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class InforPetsCell: UITableViewCell {
    @IBOutlet weak var infoLabel: UILabel?
    @IBOutlet weak var historyLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
//        infoLabel?.lineBreakMode = .byWordWrapping
//        infoLabel?.numberOfLines = 0
//        historyLabel?.lineBreakMode = .byWordWrapping
//        historyLabel?.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        infoLabel?.text = nil
        historyLabel?.text = nil
    }

    func setAnimalInfo(_ animal: Animal) {
        infoLabel?.text = animal.information
        historyLabel?.text = animal.history
    }

}
