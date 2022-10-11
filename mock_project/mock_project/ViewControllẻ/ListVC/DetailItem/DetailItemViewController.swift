//
//  DetailItemViewController.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit
import CoreData

class DetailItemViewController: UIViewController {
    @IBOutlet weak var animalTableView: UITableView?
    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var backButton: UIButton?

    private var animal: Animal?
    private let userManager = UserManager.shared
    private var favorites: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    @IBAction func didBackPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension DetailItemViewController {
    func setAnimal(_ animal: Animal) {
        self.animal = animal
    }
}
// MARK: - config UI
extension DetailItemViewController {
    func configUI() {
        favorites = Favorite.getFavoriteOfCurrentUser()
        backButton?.setStyleBackButton()
        guard let animalTableView = animalTableView else {
            return
        }
        _ = view?.applyGradient()

        animalTableView.delegate = self
        animalTableView.dataSource = self

        animalTableView.register(
            UINib(
                nibName: "NameTableViewCell",
                bundle: Bundle.main
            ),
            forCellReuseIdentifier: "nameCell"
        )
        animalTableView.register(
            UINib(
                nibName: "DescriptionTableViewCell",
                bundle: Bundle.main
            ),
            forCellReuseIdentifier: "descriptionCell"
        )
        animalTableView.register(
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
        headerTableView.imageView.image = animal?.image as? UIImage
        animalTableView.tableHeaderView = headerTableView
        animalTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tabBarController?.tabBar.isHidden = true
    }

    func didSetImage(_ url: String) -> UIImage {
        let imageLink = URL(string: url) ?? URL(fileURLWithPath: "")
        let imageData = try? Data(contentsOf: imageLink)
        let imageAnimal = UIImage(data: imageData ?? Data()) ?? UIImage()

        return imageAnimal
    }
}
// MARK: - tableview delegate
extension DetailItemViewController: UITableViewDelegate {
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
                    return UITableView.automaticDimension
                }
                return height
        }
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

        if let animal = animal {
            cell.setAnimalInfo(animal)

            let isContains = favorites.contains { favoriteObject in
                (favoriteObject.value(forKey: "species") as? String) == animal.species
            }

            if isContains {
                cell.setColordHeartButton(.red)
            } else {
                cell.setColordHeartButton(.white)
            }

            cell.heartButtonClousure = { [weak self] in

                let isInclude = self?.favorites.contains { favoriteObject in
                    (favoriteObject.value(forKey: "species") as? String) == animal.species
                }

                let animalObject = self?.favorites.filter { favoriteObject in
                    (favoriteObject.value(forKey: "species") as? String) == animal.species
                }

                if isInclude ?? true {
                    _ = Favorite.deleteFavorite(animalObject?[0] ?? NSManagedObject())
                    cell.setColordHeartButton(.white)
                } else {
                    cell.setColordHeartButton(.red)
                    _ = Favorite.insertFavorite(
                        animal,
                        self?.userManager.getUserInfo().uid ?? ""
                    )
                }
                NotificationCenter.default.post(name: NSNotification.Name.notiFicationNameFavorite, object: nil)
                DispatchQueue.main.async {
                    self?.favorites = Favorite.getFavoriteOfCurrentUser()
                }
            }
        }

        return cell
    }

    func initDescriptionCell(
        _ indexPath: IndexPath
    ) -> DescriptionTableViewCell {
        let cell = animalTableView?.dequeueReusableCell(
            withIdentifier: "descriptionCell",
            for: indexPath
        ) as? DescriptionTableViewCell ?? DescriptionTableViewCell()

        if let animal = animal {
            cell.setInfoAnimal(animal)
        }

        return cell
    }

    func initInforCell(
        _ indexPath: IndexPath
    ) -> InforPetsCell {
        let cell = animalTableView?.dequeueReusableCell(
            withIdentifier: "informationCell",
            for: indexPath
        ) as? InforPetsCell ?? InforPetsCell()

        if let animal = animal {
            cell.setAnimalInfo(animal)
        }
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
