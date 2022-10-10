//
//  LoadingView.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 07/10/2022.
//

import UIKit

class LoadingView: UIViewController {
    @IBOutlet weak var redPoint: UIView?
    @IBOutlet weak var bluePoint: UIView?
    @IBOutlet weak var blackPoint: UIView?
    @IBOutlet weak var yellowPoint: UIView?
    @IBOutlet weak var rotateView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setAnimation()
    }

    deinit {
        view.layer.removeAllAnimations()
    }

    func didDismissView() {
        self.dismiss(animated: true)
    }

}

// MARK: - CONFIG UI
extension LoadingView {
    func configUI() {
        redPoint?.layer.cornerRadius = (redPoint?.bounds.width ?? 0) / 2
        bluePoint?.layer.cornerRadius = (redPoint?.bounds.width ?? 0) / 2
        blackPoint?.layer.cornerRadius = (redPoint?.bounds.width ?? 0) / 2
        yellowPoint?.layer.cornerRadius = (redPoint?.bounds.width ?? 0) / 2
    }

    func setAnimation() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { [weak self] () -> Void in
            self?.rotateView?.transform = self?.rotateView?.transform.rotated(by: .pi / 2) ?? CGAffineTransform()
        }, completion: { [weak self] _ in
                self?.setAnimation()
        })
    }
}
