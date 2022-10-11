//
//  InformationTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 03/10/2022.
//

import UIKit

class InformationTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var detailLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        detailLabel?.text = nil
    }
}
// MARK: - config UI
extension InformationTableViewCell {
    func configUI(_ title: String, _ detail: String) {
        print(detail)
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel?.text = title
            self?.detailLabel?.text = detail
        }
    }
}
