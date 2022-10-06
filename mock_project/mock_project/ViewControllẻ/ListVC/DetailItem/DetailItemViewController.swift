//
//  DetailItemViewController.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class DetailItemViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        listTableView.delegate = self
        listTableView.dataSource = self

        listTableView.translatesAutoresizingMaskIntoConstraints = false
        listTableView.separatorStyle = .none

        listTableView.register(UINib(nibName: "NameTableViewCell",
                                     bundle: Bundle.main), forCellReuseIdentifier: "nameCell")
        listTableView.register(UINib(nibName: "DescriptionTableViewCell",
                                     bundle: Bundle.main), forCellReuseIdentifier: "descriptionCell")
        listTableView.register(UINib(nibName: "InformationTableViewCell",
                                     bundle: Bundle.main), forCellReuseIdentifier: "informationCell")

        listTableView.clipsToBounds = true
        listTableView.layer.cornerRadius = 25

        listTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

    }
}

extension DetailItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = TableCellType.init(rawValue: indexPath.row)

        switch cellType {
            case .categories:
                let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell",
                    for: indexPath) as? NameTableViewCell ?? UITableViewCell()
                return cell
            case .search:
                let cell1 = tableView.dequeueReusableCell(withIdentifier: "descriptionCell",
                    for: indexPath) as? DescriptionTableViewCell ?? UITableViewCell()

                return cell1
            default:
                let cell2 = tableView.dequeueReusableCell(withIdentifier: "informationCell",
                    for: indexPath) as? InformationTableViewCell ?? UITableViewCell()
                return cell2
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            var height: CGFloat = CGFloat()
            if indexPath.row == 0 {
                height = 120
            } else if indexPath.row == 1 {
                height = 135
            } else if indexPath.row == 2 {
                height = 400
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

enum DetailTableCellType: Int {
    case name = 0
    case description
    case information
}
