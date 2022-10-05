//
//  HandBookViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import UIKit

class HandBookViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar?
    @IBOutlet weak var navItem: UINavigationItem?
    @IBOutlet weak var handBookTableView: UITableView?

    var handBooks: [Int] = [1, 2, 3, 4]

    override func viewDidLoad() {
        super.viewDidLoad()
//        configNav()
        configTableView()
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - configNAV
extension HandBookViewController {
    private func configNav() {
        let backButton = UIBarButtonItem(
            title: "Back",
            style: .done,
            target: self,
            action: #selector(didTapBackToPrevView)
        )
        navItem?.leftBarButtonItem = backButton
    }

    @objc
    func didTapBackToPrevView() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - config tableview
extension HandBookViewController {
    func configTableView() {
        _ = view?.applyGradient()
        handBookTableView?.delegate = self
        handBookTableView?.dataSource = self
        handBookTableView?.register(
            UINib(
                nibName: String(describing: SearchTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "searchCell"
        )
        handBookTableView?.register(
            UINib(
                nibName: String(describing: PostCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "postCell"
        )
        handBookTableView?.register(
            UINib(
                nibName: String(describing: CategoriesTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "categoriesCell"
        )
    }
}

// MARK: - tableview delegate
extension HandBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else if indexPath.row == 1 {
            return 60
        } else {
            return 250
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handBookTableView?.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }

}

// MARK: - table datasource
extension HandBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        handBooks.count + 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = TableCellStyle.init(rawValue: indexPath.row)
        switch cellType {
        case .categories:
            return initCategoriesCell(indexPath)
        case .favorite:
            return initSearchCell(indexPath)
        default:
            return initPostCell(indexPath)
        }
    }

    func initCategoriesCell(
        _ indexPath: IndexPath
    ) -> CategoriesTableCell {
        let cell = handBookTableView?.dequeueReusableCell(
            withIdentifier: "categoriesCell",
            for: indexPath
        ) as? CategoriesTableCell ?? CategoriesTableCell()

        return cell
    }

    func initSearchCell(
        _ indexPath: IndexPath
    ) -> SearchTableCell {
        let cell = handBookTableView?.dequeueReusableCell(
            withIdentifier: "searchCell",
            for: indexPath
        ) as? SearchTableCell ?? SearchTableCell()

        return cell
    }

    func initPostCell(
        _ indexPath: IndexPath
    ) -> PostCell {
        let cell = handBookTableView?.dequeueReusableCell(
            withIdentifier: "postCell",
            for: indexPath
        ) as? PostCell ?? PostCell()

        return cell
    }
}
