//
//  AddColorTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 08/10/2022.
//

import UIKit

class AddColorTableViewCell: UITableViewCell {
    @IBOutlet weak var addColorTextField: UITextField?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func didGetColor() -> String {
        let petInformation: PetInformation = PetInformation()
        petInformation.color = addColorTextField?.text ?? ""
        return petInformation.color ?? ""
    }
}
