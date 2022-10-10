//
//  HealthBookTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 04/10/2022.
//

import UIKit

class HealthBookTableViewCell: UITableViewCell {
    @IBOutlet weak var contentHealthBookLabel: UILabel?
    @IBOutlet weak var detailHealthBookLabel: UILabel?
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var petName: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView?.cardShadow()
        containerView?.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        contentHealthBookLabel?.text = nil
        detailHealthBookLabel?.text = nil
        petName?.text = nil
        dateLabel?.text = nil
    }
}

extension HealthBookTableViewCell {
    func configData(_ heathBook: HeathBook) {
        DispatchQueue.main.async { [weak self] in
            self?.contentHealthBookLabel?.text = heathBook.diagnostic
            self?.detailHealthBookLabel?.text = heathBook.diagnostic
            self?.petName?.text = heathBook.petName
            self?.dateLabel?.text = heathBook.createDate
        }
    }
}
