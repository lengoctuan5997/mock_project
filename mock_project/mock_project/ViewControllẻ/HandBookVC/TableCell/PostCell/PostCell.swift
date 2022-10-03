//
//  PostCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var postView: UIView?
    @IBOutlet weak var contentPostView: UIView?
    @IBOutlet weak var postImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postView?.cardShadow()
        postView?.layer.cornerRadius = 15
        contentPostView?.cardShadow()
        contentPostView?.layer.cornerRadius = 15
        contentPostView?.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        postImage?.layer.cornerRadius = 15
        postImage?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
