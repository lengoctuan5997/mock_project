//
//  ListViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 29/09/2022.
//

import UIKit
import FirebaseFirestore

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView?
    private var animals: [Animal] = []
    private var filterAnimals: [Animal] = []
    private var isSelectype: Bool = false
    var animalType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initData()
        print(animalType, "Type")
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
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
                var animalCount: Int
                if (( isSelectype ? filterAnimals.count : animals.count) / 2) < 1 {
                    animalCount = 1
                } else {
                    animalCount = ( isSelectype ? filterAnimals.count : animals.count) / 2
                }
                height = CGFloat(animalCount * 255
                )
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

        cell.tapCategoriesCellClousure = { [weak self] (type) in
            self?.animalType = type
            self?.isSelectype = true

            self?.filter(type)
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
        // remove search value
        cell.deleteSearchValueClousure = { [weak self] in
            self?.isSelectype = self?.animalType.isEmpty == false ? true : false

            self?.filter(self?.animalType ?? "")
        }

        // start search animal
        cell.didStartSearchClousure = { [weak self] searchText in

            self?.isSelectype = true
            self?.filterAnimals = self?.animals.filter({ animal in
                return (animal.animal.lowercased() == self?.animalType.lowercased()) &&
                animal.species.lowercased().contains(searchText.lowercased())
            }) ?? []

            DispatchQueue.main.async {
                self?.listTableView?.reloadData()
            }
        }
        return cell
    }

    func initAnimalsCell(
        _ indexPath: IndexPath
    ) -> ListItemTableViewCell {
        let animalData = isSelectype ? filterAnimals : animals

        let cell = listTableView?.dequeueReusableCell(
            withIdentifier: "listItemCell",
            for: indexPath
        ) as? ListItemTableViewCell ?? ListItemTableViewCell()

        cell.setData(animalData)
        cell.tapCell = { [weak self] cellIndex in
            let detailVC = DetailItemViewController(
                nibName: String(describing: DetailItemViewController.self),
                bundle: .main
            )

            detailVC.setAnimal(animalData[cellIndex.item])
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }

        return cell
    }

    func filter(_ type: String) {
        filterAnimals = animals.filter({ animal in
            return animal.animal.lowercased() == type.lowercased()
        })
        listTableView?.reloadData()
    }
}

extension ListViewController {
    func initData() {
        let loadingView = LoadingView(nibName: String(describing: LoadingView.self), bundle: .main)
        loadingView.modalTransitionStyle = .crossDissolve
        loadingView.modalPresentationStyle = .overCurrentContext

        self.present(loadingView, animated: true)

        let dbFirestore = Firestore.firestore()

        dbFirestore
            .collection("petLibrary")
            .getDocuments { [weak self] (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let querySnapshot = querySnapshot
                else {
                    return
                }
                self?.setData(querySnapshot)
            }

            loadingView.didDismissView()
        }
    }

    func setData(_ querySnapshot: QuerySnapshot) {
        var arrAnimal: [Animal] = []
        for document in querySnapshot.documents {
            let data = document.data()
            let height = data["height"] as? String ?? ""
            let weight = data["weight"] as? String ?? ""
            let age = data["age"] as? String ?? ""
            let origin = data["origin"] as? String ?? ""
            let type = data["type"] as? String ?? ""
            let species = data["species"] as? String ?? ""
            let information = data["information"] as? String ?? ""
            let history = data["history"] as? String ?? ""
            let animal = data["animal"] as? String ?? ""

            let image = data["image"] as? String ?? ""
            let imageLink = URL(string: image) ?? URL(fileURLWithPath: "")
            let imageData = try? Data(contentsOf: imageLink)
            let imageAnimal = UIImage(data: imageData ?? Data()) as UIImage? ?? UIImage()

            let loadData = Animal(
                height: height,
                weight: weight,
                age: age,
                origin: origin,
                type: type,
                species: species,
                information: information,
                history: history,
                image: imageAnimal,
                animal: animal
            )
            arrAnimal.append(loadData)
        }
        DispatchQueue.main.async {
            self.animals = arrAnimal
            self.listTableView?.reloadData()
        }
    }
}

enum TableCellType: Int {
    case categories = 0
    case search
    case list
}
