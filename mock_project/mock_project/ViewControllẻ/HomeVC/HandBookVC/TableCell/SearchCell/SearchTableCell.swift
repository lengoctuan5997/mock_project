//
//  SearchTableCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import UIKit

class SearchTableCell: UITableViewCell {
    @IBOutlet weak var searchView: UIView?
    @IBOutlet weak var searchTextField: UITextField?

    override func awakeFromNib() {
        super.awakeFromNib()
        searchView?.cardShadow()
        searchView?.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
