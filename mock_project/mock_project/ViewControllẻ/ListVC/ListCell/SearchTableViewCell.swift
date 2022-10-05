//
//  SearchTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        imageView.image = image

        searchTextField.leftView = imageView
        searchTextField.leftViewMode = .always
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
