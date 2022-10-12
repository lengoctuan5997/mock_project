//
//  AddNamePetTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 08/10/2022.
//

import UIKit

class AddNamePetTableViewCell: UITableViewCell {
    @IBOutlet weak var namePetTextField: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func didGetName() -> String {
        let petInformation: PetInformation = PetInformation()
        petInformation.name = namePetTextField?.text ?? ""
        return petInformation.name ?? ""
    }
}
