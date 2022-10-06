//
//  ListViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listTableView.delegate = self
        listTableView.dataSource = self

        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.separatorStyle = .none

        listTableView.register(UINib(nibName: "CategoryTableViewCell",
                                     bundle: Bundle.main), forCellReuseIdentifier: "categoryCell")
        listTableView.register(UINib(nibName: "SearchTableViewCell",
                                     bundle: Bundle.main), forCellReuseIdentifier: "searchCell")
        listTableView.register(UINib(nibName: "ListItemTableViewCell",
                                     bundle: Bundle.main), forCellReuseIdentifier: "listItemCell")
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = TableCellType.init(rawValue: indexPath.row)

        switch cellType {
            case .categories:
                let cell = tableView.dequeueReusableCell(withIdentifier:
                    "categoryCell", for: indexPath) as? CategoryTableViewCell ?? UITableViewCell()
                return cell
            case .search:
                let cell1 = tableView.dequeueReusableCell(withIdentifier:
                    "searchCell", for: indexPath) as? SearchTableViewCell ?? UITableViewCell()
                return cell1
            default:
                let cell2 = tableView.dequeueReusableCell(withIdentifier:
                "listItemCell", for: indexPath) as? ListItemTableViewCell ?? ListItemTableViewCell()
            cell2.tapCell = { [weak self] in
                print("clousure work")

                let detailVC = DetailItemViewController(nibName:
                String(describing: DetailItemViewController.self), bundle: .main)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
                return cell2

        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            var height: CGFloat = CGFloat()
            if indexPath.row == 0 {
                height = 100
            } else if indexPath.row == 1 {
                height = 50
            } else if indexPath.row == 2 {
                height = 1500
            }
            return height
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.row == 1 {
            tableView.deselectRow(at: indexPath, animated: true)
        } else if indexPath.row == 2 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

enum TableCellType: Int {
    case categories = 0
    case search
    case list
}
