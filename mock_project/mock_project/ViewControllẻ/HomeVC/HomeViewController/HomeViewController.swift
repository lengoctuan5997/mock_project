//
//  HomeViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var homeContentTable: UITableView?
    @IBOutlet weak var accountNameLabel: UILabel?

    let userManager = UserManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()

        configTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.accountNameLabel?.text = self.userManager.getUserInfo().fullName
    }
}
// MARK: - config View
extension HomeViewController {
    func configView() {
        self.navigationController?.navigationBar.isHidden = true
        _ = contentView?.applyGradient(30)
//        contentView?.layer.masksToBounds = true
        contentView?.layer.cornerRadius = 30
        contentView?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        contentView?.cardShadow()
    }

    func configTableView() {
        homeContentTable?.register(
            UINib(
                nibName: String(describing: CategoriesTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "categoriesCell"
        )
        homeContentTable?.register(
            UINib(
                nibName: String(describing: FavoriteTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "favoriteCell"
        )
        homeContentTable?.register(
            UINib(
                nibName: String(describing: LibraryTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "libraryCell"
        )
        homeContentTable?.delegate = self
        homeContentTable?.dataSource = self
//        homeContentTable?.sectionFooterHeight = 10
        homeContentTable?.sectionHeaderHeight = 10
    }
}
// MARK: - table delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        willDisplayHeaderView view: UIView,
        forSection section: Int
    ) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .black
        }
    }

    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        0
    }
}

// MARK: - table datasource
extension HomeViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        ["", "Favorite", "Library"][section]
    }

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        3
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        let cellType = TableCellStyle.init(rawValue: indexPath.section)
        switch cellType {
        case .categories:
            return 95
        case .favorite:
            return 195
        default:
            return 530
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let rowStyle = TableCellStyle.init(rawValue: indexPath.section)
        switch rowStyle {
        case .categories:
            return initCategoriesCell(indexPath)
        case .favorite:
            return initFavoriteCell(indexPath)
        default:
            return initLibraryCell(indexPath)
        }
    }

    func initCategoriesCell(
        _ indexPath: IndexPath
    ) -> CategoriesTableCell {
        let cell = homeContentTable?.dequeueReusableCell(
            withIdentifier: "categoriesCell",
            for: indexPath
        ) as? CategoriesTableCell ?? CategoriesTableCell()

        cell.tapCategoriesCellClousure = { [weak self] in
            self?.tabBarController?.selectedIndex = 1
        }

        return cell
    }

    func initFavoriteCell(
        _ indexPath: IndexPath
    ) -> FavoriteTableCell {
        let cell = homeContentTable?.dequeueReusableCell(
            withIdentifier: "favoriteCell",
            for: indexPath
        ) as? FavoriteTableCell ?? FavoriteTableCell()

        cell.favoriteTapCellClousure = { [weak self] in
            let favoriteVC = FavoriteViewController(
                nibName: String(describing: FavoriteViewController.self),
                bundle: .main
            )

            self?.navigationController?.pushViewController(favoriteVC, animated: true)
        }

        return cell
    }

    func initLibraryCell(
        _ indexPath: IndexPath
    ) -> LibraryTableCell {
        let cell = homeContentTable?.dequeueReusableCell(
            withIdentifier: "libraryCell",
            for: indexPath
        ) as? LibraryTableCell ?? LibraryTableCell()

        cell.libraryTapCellClousure = { [weak self] in
            print("click")
            let handBookVC = HandBookViewController(
                nibName: String(
                    describing: HandBookViewController.self
                ),
                bundle: .main
            )
            self?.navigationController?.pushViewController(handBookVC, animated: true)
        }

        return cell
    }
}
