//
//  NameTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    @IBOutlet weak var animalName: UILabel?
    @IBOutlet weak var animalOrigin: UILabel?
    @IBOutlet weak var animalSpecies: UILabel?
    @IBOutlet weak var heartButton: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton?.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        animalName?.text = nil
        animalOrigin?.text = nil
        animalSpecies?.text = nil
    }

    func setAnimalInfo(_ animal: Animal) {
        animalName?.text = animal.species
        animalOrigin?.text = animal.origin
        animalSpecies?.text = animal.type
    }

}
