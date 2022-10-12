//
//  InforPetTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 04/10/2022.
//

import UIKit

class InforPetTableViewCell: UITableViewCell {
    @IBOutlet weak var birthdayLabel: UILabel?
    @IBOutlet weak var colorLabel: UILabel?
    @IBOutlet weak var sexLabel: UILabel?
    @IBOutlet weak var speciesLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func didSetData(_ petInfor: PetInformation) {
        DispatchQueue.main.async { [weak self] in
            self?.birthdayLabel?.text = petInfor.birthday
            self?.colorLabel?.text = petInfor.color
            self?.sexLabel?.text = petInfor.sex
            self?.speciesLabel?.text = petInfor.species
            self?.nameLabel?.text = petInfor.name
        }
    }
}
