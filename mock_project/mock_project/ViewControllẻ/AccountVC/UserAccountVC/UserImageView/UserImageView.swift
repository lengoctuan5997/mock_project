//
//  UserImageView.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 11/10/2022.
//

import UIKit

class UserImageView: UIViewController {
    @IBOutlet weak var container: UIView?
    @IBOutlet private weak var userImage: UIImageView?
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.setBorder(1, .white)
        closeButton.layer.cornerRadius = closeButton.bounds.width / 2
    }

    func didSetUserImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.userImage?.image = image
        }
    }

    @IBAction func didTapCloseView(_ sender: Any) {
        self.dismiss(animated: true)
        NotificationCenter.default.post(name: Notification.Name.notiFiTabbarHidden, object: nil)
    }
}
