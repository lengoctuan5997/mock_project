//
//  NameTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    @IBOutlet private weak var animalName: UILabel?
    @IBOutlet private weak var animalOrigin: UILabel?
    @IBOutlet private weak var animalSpecies: UILabel?
    @IBOutlet private weak var heartButton: UIButton?
    
    var heartButtonClousure: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton?.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didAddToFavorite(_ sender: Any) {
        heartButtonClousure()
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
