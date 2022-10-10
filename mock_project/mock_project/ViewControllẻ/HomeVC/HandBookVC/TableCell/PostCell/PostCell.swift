//
//  PostCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet private weak var postView: UIView?
    @IBOutlet private weak var contentPostView: UIView?
    @IBOutlet private weak var postImage: UIImageView?
    @IBOutlet private weak var postTitle: UILabel?
    @IBOutlet private weak var postDescription: UILabel?

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

    override func prepareForReuse() {
        postImage?.image = nil
        postTitle?.text = nil
        postDescription?.text = nil
    }

}

// MARK: - CONFIG DATA
extension PostCell {
    func didSetData(_ post: HandBook) {
        postImage?.image = post.image
        postTitle?.text = post.title
        postDescription?.text = post.title
    }

    func didSetData(_ post: Training) {
        postImage?.image = post.image
        postTitle?.text = post.title
        postDescription?.text = post.title
    }
}
