//
//  TrainingViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 05/10/2022.
//

import UIKit
import FirebaseFirestore

class TrainingViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar?
    @IBOutlet weak var navItem: UINavigationItem?
    @IBOutlet weak var trainingTableView: UITableView?
    @IBOutlet weak var backButton: UIButton?

    private var trainingAnimals: [Training] = []
    private var filterTraining: [Training] = []
    private var isFilter: Bool = false
    private var animalType: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()

        didLoadTraining()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func didTapHomeView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - config tableview
extension TrainingViewController {
    func configUI() {
        _ = view?.applyGradient()
        backButton?.setStyleBackButton()
        trainingTableView?.delegate = self
        trainingTableView?.dataSource = self
        trainingTableView?.register(
            UINib(
                nibName: String(describing: SearchTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "searchCell"
        )
        trainingTableView?.register(
            UINib(
                nibName: String(describing: PostCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "postCell"
        )
        trainingTableView?.register(
            UINib(
                nibName: String(describing: CategoriesTableCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: "categoriesCell"
        )
    }
}

// MARK: - tableview delegate
extension TrainingViewController: UITableViewDelegate {
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
        trainingTableView?.deselectRow(at: indexPath, animated: true)
        if indexPath.row > 1 {
            let trainingDetailVC = TrainingDetailVC(nibName: String(describing: TrainingDetailVC.self), bundle: .main)

            trainingDetailVC.didSetTraining(trainingAnimals[indexPath.row - 2])
            navigationController?.pushViewController(trainingDetailVC, animated: true)
        }
        print("tap")
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        true
    }

}

// MARK: - table datasource
extension TrainingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trainings = isFilter ? (filterTraining.count + 2) : (trainingAnimals.count + 2)
        return trainings
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
        let cell = trainingTableView?.dequeueReusableCell(
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
        let cell = trainingTableView?.dequeueReusableCell(
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

            self?.filterTraining = self?.trainingAnimals.filter({ training in
                let isSelected: Bool = self?.animalType.isEmpty == true ? true
                : (training.animal?.lowercased() == self?.animalType.lowercased())
                return isSelected &&
                training.title.lowercased().contains(searchText.lowercased())
            }) ?? []
            self?.trainingTableView?.reloadData()
        }

        return cell
    }

    func initPostCell(
        _ indexPath: IndexPath
    ) -> PostCell {
        let trainings = isFilter ? filterTraining : trainingAnimals

        let cell = trainingTableView?.dequeueReusableCell(
            withIdentifier: "postCell",
            for: indexPath
        ) as? PostCell ?? PostCell()

        cell.didSetData(trainings[indexPath.row - 2])
        return cell
    }
}

// MARK: - LOAD DATA
extension TrainingViewController {

    func filter(_ type: String) {
        filterTraining = trainingAnimals.filter({ handBook in
            return handBook.animal?.lowercased() == type.lowercased()
        })
        trainingTableView?.reloadData()
    }

    func didLoadTraining() {
        let loadingView = LoadingView(
            nibName: String(describing: LoadingView.self),
            bundle: .main
        )
        loadingView.modalTransitionStyle = .crossDissolve
        loadingView.modalPresentationStyle = .overCurrentContext

        self.present(loadingView, animated: true)

        let dbFirestore = Firestore.firestore()

        dbFirestore
            .collection("training")
            .getDocuments { [weak self] (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let querySnapshot = querySnapshot
                else {
                    return
                }
                self?.setData(querySnapshot, loadingView)
            }
        }
    }

    func setData(
        _ querySnapshot: QuerySnapshot,
        _ loadingView: LoadingView
    ) {
        var trainings: [Training] = []
        for document in querySnapshot.documents {
            let data = document.data()
            let animal = data["animal"] as? String ?? ""
            let description = data["description"] as? String ?? ""
            let title = data["title"] as? String ?? ""

            let image = data["image"] as? String ?? ""
            let imageLink = URL(string: image) ?? URL(fileURLWithPath: "")
            let imageData = try? Data(contentsOf: imageLink)
            let imageAnimal = UIImage(data: imageData ?? Data()) as UIImage? ?? UIImage()

            let loadData = Training()
            loadData.animal = animal
            loadData.image = imageAnimal
            loadData.description = description
            loadData.title = title

            trainings.append(loadData)
        }
        print("training \(trainings.count)")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            loadingView.didDismissView()
            self.trainingAnimals = trainings
            self.trainingTableView?.reloadData()
        }
    }
}
