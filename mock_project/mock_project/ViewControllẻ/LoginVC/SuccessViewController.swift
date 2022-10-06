//
//  SuccessViewController.swift
//  mock_project
//
//  Created by Le on 05/10/2022.
//

import UIKit

class SuccessViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel?
    var text: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel?.text = text
    }

    @IBAction func didTapLoginView(_ sender: Any) {
        let tabbarVC = TabbarController(nibName: "TabbarController", bundle: nil)
        tabbarVC.modalPresentationStyle = .fullScreen
        self.present(tabbarVC, animated: true, completion: nil)
    }
}
