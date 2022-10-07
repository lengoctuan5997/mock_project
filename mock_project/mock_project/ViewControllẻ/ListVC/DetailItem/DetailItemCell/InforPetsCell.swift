//
//  InformationTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class InforPetsCell: UITableViewCell {
    @IBOutlet weak var infoLabel: UITextView?
    @IBOutlet weak var historyLabel: UITextView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
