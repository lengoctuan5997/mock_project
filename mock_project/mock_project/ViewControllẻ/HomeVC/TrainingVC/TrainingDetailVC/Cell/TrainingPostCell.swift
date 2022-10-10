//
//  TrainingPostCell.swift
//  mock_project
//
//  Created by Le on 09/10/2022.
//

import UIKit

class TrainingPostCell: UITableViewCell {

    @IBOutlet weak var titleTraining: UILabel?
    @IBOutlet weak var descriptionTraining: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        titleTraining?.text = nil
        descriptionTraining?.text = nil
    }
}

extension TrainingPostCell {
    func didSetData(_ training: Training) {
        titleTraining?.text = training.title
        descriptionTraining?.text = training.description
    }
}
