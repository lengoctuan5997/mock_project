//
//  DetailItemViewController.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class DetailItemViewController: UIViewController {
    @IBOutlet weak var animalTableView: UITableView?
    @IBOutlet weak var containerView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}
// MARK: - config UI
extension DetailItemViewController {
    func configUI() {
//        guard let animalTableView = animalTableView else {
//            return
//        }
        _ = containerView?.applyGradient()

        animalTableView?.delegate = self
        animalTableView?.dataSource = self

        animalTableView?.register(
            UINib(
                nibName: "NameTableViewCell",
                bundle: Bundle.main
            ),
            forCellReuseIdentifier: "nameCell"
        )
        animalTableView?.register(
            UINib(
                nibName: "DescriptionTableViewCell",
                bundle: Bundle.main
            ),
            forCellReuseIdentifier: "descriptionCell"
        )
        animalTableView?.register(
            UINib(
                nibName: "InforPetsCell",
                bundle: Bundle.main
            ),
            forCellReuseIdentifier: "informationCell"
        )

        let headerTableView = StretchyTableHeaderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.bounds.width,
                height: 300
            )
        )
        headerTableView.imageView.image = UIImage(named: "dog_f3")
        animalTableView?.tableHeaderView = headerTableView
        animalTableView?.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
    }
}
// MARK: - tableview delegate
extension DetailItemViewController: UITableViewDelegate {

}

extension DetailItemViewController: UITableViewDataSource {
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
            return initNameCell(indexPath)
        case .search:
            return initDescriptionCell(indexPath)
        default:
            return initInforCell(indexPath)
        }
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
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

    func initNameCell(
        _ indexPath: IndexPath
    ) -> NameTableViewCell {
        let cell = animalTableView?.dequeueReusableCell(
            withIdentifier: "nameCell",
            for: indexPath
        ) as? NameTableViewCell ?? NameTableViewCell()
        return cell
    }

    func initDescriptionCell(
        _ indexPath: IndexPath
    ) -> DescriptionTableViewCell {
        let cell = animalTableView?.dequeueReusableCell(
            withIdentifier: "descriptionCell",
            for: indexPath
        ) as? DescriptionTableViewCell ?? DescriptionTableViewCell()
        return cell
    }

    func initInforCell(
        _ indexPath: IndexPath
    ) -> InforPetsCell {
        let cell = animalTableView?.dequeueReusableCell(
            withIdentifier: "informationCell",
            for: indexPath
        ) as? InforPetsCell ?? InforPetsCell()
        return cell
    }
}

// MARK: - scroll table
extension DetailItemViewController {
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        let headerTableView = animalTableView?.tableHeaderView as? StretchyTableHeaderView
        headerTableView?.scrollViewDidScroll(scrollView: scrollView)
    }
}

enum DetailTableCellType: Int {
    case name = 0
    case description
    case information
}
