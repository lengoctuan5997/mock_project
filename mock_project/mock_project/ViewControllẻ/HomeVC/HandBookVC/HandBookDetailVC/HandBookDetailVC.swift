//
//  HandBookDetailVC.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 08/10/2022.
//

import UIKit

class HandBookDetailVC: UIViewController {
    @IBOutlet weak var handBookDetailTable: UITableView?
    @IBOutlet weak var backButton: UIButton?

    private var handBook: HandBook?
    private var handBookCell: String = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func didBackToPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}
// MARK: - CONFIG UI
extension HandBookDetailVC {
    func configUI() {
        _ = view.applyGradient()
        backButton?.setStyleBackButton()
        handBookDetailTable?.delegate = self
        handBookDetailTable?.dataSource = self
        handBookDetailTable?.register(
            UINib(
                nibName: String(describing: HandBookPostCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: handBookCell
        )

        let headerView = StretchyTableHeaderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: 300
            )
        )

        headerView.imageView.image = handBook?.image
        handBookDetailTable?.tableHeaderView = headerView
        handBookDetailTable?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func didSetHandBook(_ handBook: HandBook) {
        self.handBook = handBook
    }
}

// MARK: - DELEGATE
extension HandBookDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - DATASOURCE
extension HandBookDetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = handBookDetailTable?.dequeueReusableCell(
            withIdentifier: handBookCell,
            for: indexPath
        ) as? HandBookPostCell ?? HandBookPostCell()

        cell.didSetData(handBook ?? HandBook())
        return cell
    }
}

// MARK: - scroll table
extension HandBookDetailVC {
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        let headerTableView = handBookDetailTable?.tableHeaderView as? StretchyTableHeaderView
        headerTableView?.scrollViewDidScroll(scrollView: scrollView)
    }
}
