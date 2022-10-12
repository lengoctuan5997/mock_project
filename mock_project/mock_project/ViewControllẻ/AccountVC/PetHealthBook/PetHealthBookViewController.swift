//
//  PetHealthBookViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 04/10/2022.
//

import UIKit
import FirebaseFirestore

class PetHealthBookViewController: UIViewController {
    @IBOutlet weak var healthBookTableView: UITableView?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var addButton: UIButton?

    private let healthBookCell: String = "healthBookCell"
    private var heathBooks: [HeathBook] = []
    private let userManager = UserManager.shared
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
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
    }

    @IBAction func didTapBackToPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapAddHeathBook(_ sender: Any) {
        let newHeathBook = NewPetHeathVC(nibName: String(describing: NewPetHeathVC.self), bundle: .main)

        navigationController?.pushViewController(newHeathBook, animated: true)
    }
}

extension PetHealthBookViewController {
    private func setupUI() {
        self.present(loadingView, animated: true)
        _ = view.applyGradient()
        backButton?.setStyleBackButton()
        addButton?.setStyleBackButton()
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true

        healthBookTableView?.delegate = self
        healthBookTableView?.dataSource = self
        healthBookTableView?.sectionHeaderHeight = 10
        healthBookTableView?.register(
            UINib(
                nibName: String(
                    describing: HealthBookTableViewCell.self
                ),
                bundle: nil
            ),
            forCellReuseIdentifier: healthBookCell
        )
        initData()
    }
}

extension PetHealthBookViewController {
    @objc
    func didTapAddButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension PetHealthBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        100
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        print("tap")
        healthBookTableView?.deselectRow(at: indexPath, animated: true)

        let detailVC = PetHeathDetailVC(nibName: "PetHeathDetailVC", bundle: .main)
        detailVC.setHeathBook(heathBooks[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }

//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        false
//    }
}

extension PetHealthBookViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return heathBooks.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let healthBookCell = healthBookTableView?.dequeueReusableCell(
            withIdentifier: healthBookCell
        ) as? HealthBookTableViewCell else {
            return HealthBookTableViewCell()
        }

        healthBookCell.configData(heathBooks[indexPath.row])

        return healthBookCell
    }
}

// MARK: - GET DATA FROM FIREBASE
extension PetHealthBookViewController {
    func initData() {
        let dbFirestore = Firestore.firestore()
        dbFirestore
            .collection("heathBook")
            .getDocuments { [weak self] (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
                self?.loadingView.didDismissView()
            } else {
                guard let querySnapshot = querySnapshot
                else {
                    return
                }
                self?.setData(querySnapshot)
            }
        }
    }

    func setData(_ querySnapshot: QuerySnapshot) {
        var heathBooks: [HeathBook] = []
        for document in querySnapshot.documents {
            let heathBook = HeathBook()

            let data = document.data()
            heathBook.petName = data["petName"] as? String ?? ""
            heathBook.createDate = data["createDate"] as? String ?? ""
            heathBook.treatmentProcess = data["treatmentProcess"] as? String ?? ""
            heathBook.diagnostic = data["diagnostic"] as? String ?? ""
            heathBook.examinationPlace = data["examinationPlace"] as? String ?? ""
            heathBook.symptom = data["symptom"] as? String ?? ""
            heathBook.uId = data["uId"] as? String ?? ""
            heathBook.note = data["note"] as? String ?? ""
            heathBook.vaccination = data["vaccination"] as? String ?? ""
            heathBook.vacxinType = data["vacxinType"] as? String ?? ""

            if heathBook.uId == userManager.getUserInfo().uid {
                heathBooks.append(heathBook)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.heathBooks = heathBooks
            self?.healthBookTableView?.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.loadingView.didDismissView()
        }
    }
}
