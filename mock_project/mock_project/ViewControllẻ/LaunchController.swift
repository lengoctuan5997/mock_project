//
//  ViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

class LaunchController: UIViewController {
    @IBOutlet var launchView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        launchView?.backgroundColor = .red
//        _ = launchView?.applyGradient()
    }
}
