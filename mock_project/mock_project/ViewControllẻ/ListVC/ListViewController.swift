//
//  ListViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}
// MARK: - config UI
extension ListViewController {
    func configUI() {
        _ = view.applyGradient()
        guard let listTableView = listTableView
        else {
            return
        }

        listTableView.delegate = self
        listTableView.dataSource = self

        listTableView.register(
            UINib(
                nibName: "CategoryTableViewCell",
                 bundle: Bundle.main
            ),
            forCellReuseIdentifier: "categoryCell"
        )
        listTableView.register(
            UINib(
                nibName: String(describing: SearchTableCell.self),
                bundle: Bundle.main
            ),
            forCellReuseIdentifier: "searchCell")
        listTableView.register(
            UINib(
                nibName: "ListItemTableViewCell",
                bundle: Bundle.main),
            forCellReuseIdentifier: "listItemCell"
        )
    }
}

// MARL: - tableview delegate
extension ListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.row == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.row == 2 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
extension ListViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        3
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cellType = TableCellType.init(rawValue: indexPath.row)

        switch cellType {
        case .categories:
            return initCategoriesCell(indexPath)
        case .search:
            return initSearchCell(indexPath)
        default:
            return initAnimalsCell(indexPath)

        }
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
            var height: CGFloat = CGFloat()
            if indexPath.row == 0 {
                height = 100
            } else if indexPath.row == 1 {
                height = 60
            } else if indexPath.row == 2 {
                height = 1500
            }
            return height
    }

    func initCategoriesCell(
        _ indexPath: IndexPath
    ) -> CategoriesTableCell {
        let cell = listTableView?.dequeueReusableCell(
            withIdentifier:
            "categoryCell",
            for: indexPath
        ) as? CategoriesTableCell ?? CategoriesTableCell()

        return cell
    }

    func initSearchCell(
        _ indexPath: IndexPath
    ) -> SearchTableViewCell {
        let cell = listTableView?.dequeueReusableCell(
            withIdentifier:
            "searchCell",
            for: indexPath
        ) as? SearchTableViewCell ?? SearchTableViewCell()
        return cell
    }

    func initAnimalsCell(
        _ indexPath: IndexPath
    ) -> ListItemTableViewCell {
        let cell = listTableView?.dequeueReusableCell(
            withIdentifier: "listItemCell",
            for: indexPath
        ) as? ListItemTableViewCell ?? ListItemTableViewCell()

        cell.tapCell = { [weak self] in
            print("clousure work")

            let detailVC = DetailItemViewController(
                nibName: String(describing: DetailItemViewController.self),
                bundle: .main
            )
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }

        return cell
    }
}

enum TableCellType: Int {
    case categories = 0
    case search
    case list
}
