//
//  ListPetTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 05/10/2022.
//

import UIKit

class ListPetTableViewCell: UITableViewCell {
    @IBOutlet weak var speciesLabel: UILabel?
    @IBOutlet weak var petNameLabel: UILabel?
    @IBOutlet weak var petAvatar: UIImageView?
    @IBOutlet weak var container: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        petAvatar?.layer.cornerRadius = (petAvatar?.bounds.width ?? 0) / 2
        container?.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
          super.layoutSubviews()
          let margins = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
          contentView.frame = contentView.frame.inset(by: margins)
          contentView.layer.cornerRadius = 8
    }

    override func prepareForReuse() {
        speciesLabel?.text = nil
        petNameLabel?.text = nil
    }
}

extension ListPetTableViewCell {
    func configPetData(_ petInformation: PetInformation) {
        DispatchQueue.main.async { [weak self] in
            self?.speciesLabel?.text = petInformation.species
            self?.petNameLabel?.text = petInformation.name
        }
    }
}
