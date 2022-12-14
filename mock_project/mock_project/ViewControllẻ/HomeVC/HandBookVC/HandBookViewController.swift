//
//  HandBookViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import UIKit
import FirebaseFirestore

class HandBookViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar?
    @IBOutlet weak var navItem: UINavigationItem?
    @IBOutlet weak var handBookTableView: UITableView?
    @IBOutlet weak var backButton: UIButton?

    var viewModel: HandBookViewModel?
    private var handBookAnimals: [HandBook] = []
    private var filterHandBook: [HandBook] = []
    private var isFilter: Bool = false
    private var animalType: String = ""
    
    private let loadingView: LoadingView = {
        let loadingView = LoadingView(
            nibName: "LoadingView",
            bundle: .main
        )

        loadingView.modalPresentationStyle = .overCurrentContext
        loadingView.modalTransitionStyle = .crossDissolve

        return loadingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

        didLoadHandBook()
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - configNAV
extension HandBookViewController {
    @IBAction private func didTapBackToPrevView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - config tableview
extension HandBookViewController {
    func configUI() {
        _ = view?.applyGradient()
        backButton?.setStyleBackButton()
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

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        handBookTableView?.deselectRow(at: indexPath, animated: true)
        if indexPath.row > 1 {
            let handbookDetailVC = HandBookDetailVC(
                nibName: String(describing: HandBookDetailVC.self),
                bundle: .main
            )

            handbookDetailVC.didSetHandBook(handBookAnimals[indexPath.row - 2])
            navigationController?.pushViewController(handbookDetailVC, animated: true)
        }
        print("tap")
    }

    func tableView(
        _ tableView: UITableView,
        shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        true
    }

}

// MARK: - table datasource
extension HandBookViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        let handBooks = isFilter ? (filterHandBook.count + 2) : (handBookAnimals.count + 2)
        return handBooks
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
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

        cell.tapCategoriesCellClousure = { [weak self] (type) in
            self?.animalType = type
            self?.isFilter = true

            self?.filter(type)
        }
        return cell
    }

    func initSearchCell(
        _ indexPath: IndexPath
    ) -> SearchTableCell {
        let cell = handBookTableView?.dequeueReusableCell(
            withIdentifier: "searchCell",
            for: indexPath
        ) as? SearchTableCell ?? SearchTableCell()

        // delete search
        cell.deleteSearchValueClousure = { [weak self] in
            self?.isFilter = self?.animalType.isEmpty == true ? false : true
            self?.filter(self?.animalType ?? "")
        }

        // search handbook
        cell.didStartSearchClousure = { [weak self] (searchText) in
            self?.isFilter = true

            self?.filterHandBook = self?.handBookAnimals.filter({ handbook in
                let isSelected: Bool = self?.animalType.isEmpty == true ? true
                : (handbook.animal?.lowercased() == self?.animalType.lowercased())
                return isSelected &&
                handbook.title.lowercased().contains(searchText.lowercased())
            }) ?? []
            self?.handBookTableView?.reloadData()
        }

        return cell
    }

    func initPostCell(
        _ indexPath: IndexPath
    ) -> PostCell {
        let handBooks = isFilter ? filterHandBook : handBookAnimals

        let cell = handBookTableView?.dequeueReusableCell(
            withIdentifier: "postCell",
            for: indexPath
        ) as? PostCell ?? PostCell()

        cell.didSetData(handBooks[indexPath.row - 2])
        return cell
    }
}

// MARK: - LOAD DATA
extension HandBookViewController {

    func filter(_ type: String) {
        filterHandBook = handBookAnimals.filter({ handBook in
            return handBook.animal?.lowercased() == type.lowercased()
        })
        handBookTableView?.reloadData()
    }

    func didLoadHandBook() {
        self.present(loadingView, animated: true)
        viewModel?.getHandBook {
            self.handBookAnimals = self.viewModel?.handBooks() ?? []
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.loadingView.didDismissView()
                self?.handBookTableView?.reloadData()
            }
        }
    }
}
