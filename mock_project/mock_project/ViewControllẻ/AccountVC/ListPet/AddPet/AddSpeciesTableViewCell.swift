//
//  AddSpeciesTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 06/10/2022.
//

import UIKit

class AddSpeciesTableViewCell: UITableViewCell {
    @IBOutlet weak var speciesTextField: UITextField?
    @IBOutlet weak var speciesPickerView: UIPickerView!

    var species = [Species]()

    override func awakeFromNib() {
        super.awakeFromNib()
        speciesPickerView?.delegate = self
        speciesPickerView?.dataSource = self

        species.append(Species(species: "Chó", nameSpecies: ["Husky", "Bull", "Corgi"]))
        species.append(Species(species: "Mèo", nameSpecies: ["Tam thể", "Anh lông ngắn", "Xiêm"]))
        species.append(Species(species: "Cá", nameSpecies: ["Koi", "Betta", "Neon"]))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func didGetSpecies() -> String {
        let petInformation: PetInformation = PetInformation()
        petInformation.species = speciesTextField?.text ?? ""
        return petInformation.species ?? ""
    }
}

class Species {
    var species: String
    var nameSpecies: [String]

    init(species: String, nameSpecies: [String]) {
        self.species = species
        self.nameSpecies = nameSpecies
    }
}

extension AddSpeciesTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return species.count
        }
        else {
            let selectedSpecies = speciesPickerView.selectedRow(inComponent: 0)
            return species[selectedSpecies].nameSpecies.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return species[row].species
        }
        else {
            let selectedSpecies = speciesPickerView.selectedRow(inComponent: 0)
            return species[selectedSpecies].nameSpecies[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        speciesPickerView.reloadComponent(1)

        let selectedSpecies = speciesPickerView.selectedRow(inComponent: 0)
        let selectedNameSpecies = speciesPickerView.selectedRow(inComponent: 1)
        let specie = species[selectedSpecies].species
        let nameSpecies = species[selectedSpecies].nameSpecies[selectedNameSpecies]

        speciesTextField?.text = "\(specie) \(nameSpecies)"
    }
}
