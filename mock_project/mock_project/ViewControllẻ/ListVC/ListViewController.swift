//
//  ListViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView?
    private var animals: [Animal] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initData()
    }
}
// MARK: - config UI
extension ListViewController {
    func configUI() {
        self.setupToHideKeyboardOnTapOnView()
        navigationController?.isNavigationBarHidden = true
        _ = view.applyGradient()
        guard let listTableView = listTableView
        else {
            return
        }

        listTableView.delegate = self
        listTableView.dataSource = self

        listTableView.register(
            UINib(
                nibName: String(describing: CategoriesTableCell.self),
                 bundle: Bundle.main
            ),
            forCellReuseIdentifier: "categoryCell"
        )
        listTableView.register(
            UINib(
                nibName: String(describing: SearchTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "searchAnimalCell")
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
                print(animals.count * 260)
                height = CGFloat((animals.count / 2) * 260)
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

        cell.tapCategoriesCellClousure = { [weak self] in
            print("select type")
        }
        return cell
    }

    func initSearchCell(
        _ indexPath: IndexPath
    ) -> SearchTableCell {
        let cell = listTableView?.dequeueReusableCell(
            withIdentifier:
            "searchAnimalCell",
            for: indexPath
        ) as? SearchTableCell ?? SearchTableCell()
        return cell
    }

    func initAnimalsCell(
        _ indexPath: IndexPath
    ) -> ListItemTableViewCell {
        let cell = listTableView?.dequeueReusableCell(
            withIdentifier: "listItemCell",
            for: indexPath
        ) as? ListItemTableViewCell ?? ListItemTableViewCell()
        cell.animals = animals
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

extension ListViewController {
    func initData() {
        animals = [
            Animal(height: 10, weight: 10, age: 19, origin: "Japan", type: "dog", species: "", information: "", history: "", image: "dog_f1", animal: "dog"),
            Animal(height: 10, weight: 10, age: 19, origin: "Japan", type: "dog", species: "", information: "", history: "", image: "catF", animal: "cat"),
            Animal(height: 10, weight: 10, age: 19, origin: "Japan", type: "bird", species: "", information: "", history: "", image: "bird-1", animal: "bird"),
            Animal(height: 10, weight: 10, age: 19, origin: "Japan", type: "dog", species: "", information: "", history: "", image: "fish-1", animal: "fish"),]
    }
}

enum TableCellType: Int {
    case categories = 0
    case search
    case list
}
