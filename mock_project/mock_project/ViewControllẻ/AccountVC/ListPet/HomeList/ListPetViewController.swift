//
//  ListPetViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 05/10/2022.
//

import UIKit
import FirebaseFirestore

class ListPetViewController: UIViewController {
    @IBOutlet weak var listPetTableView: UITableView?

    let listCell: String = "listPetCell"
    private var petInformations: [PetInformation] = []
    private let userManager = UserManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        let loadingView = LoadingView(nibName: String(describing: LoadingView.self), bundle: .main)
        loadingView.modalTransitionStyle = .crossDissolve
        loadingView.modalPresentationStyle = .overCurrentContext

        self.present(loadingView, animated: true)
        initPetData(loadingView)
    }
}

extension ListPetViewController {
    private func setupUI() {
        _ = view.applyGradient()
        self.navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        let addPetButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self,
            action: #selector(didTapAddPetButton)
        )
        navigationItem.rightBarButtonItem = addPetButton
        listPetTableView?.delegate = self
        listPetTableView?.dataSource = self
        listPetTableView?.register(
            UINib(
                nibName: String(
                    describing: ListPetTableViewCell.self
                ),
                bundle: nil
            ),
            forCellReuseIdentifier: listCell)
    }
}

extension ListPetViewController {
    @objc
    func didTapAddPetButton() {
        navigationController?.pushViewController(AddPetViewController(), animated: true)
    }
}

extension ListPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inforPetVC = InformationPetViewController(nibName: "InformationPetViewController", bundle: .main)
        inforPetVC.setPetInfor(petInformations[indexPath.row])
            navigationController?.pushViewController(inforPetVC, animated: true)
        listPetTableView?.deselectRow(at: indexPath, animated: true)
    }
}

extension ListPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petInformations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = listPetTableView?.dequeueReusableCell(
            withIdentifier: listCell) as? ListPetTableViewCell else {
            return ListPetTableViewCell()
        }
        listCell.configPetData(petInformations[indexPath.row])
        return listCell
    }
}

extension ListPetViewController {
    func initPetData(_ loadingView: LoadingView) {
        let dbFirestore = Firestore.firestore()
        dbFirestore
            .collection("myPet")
            .getDocuments { [weak self] (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let querySnapshot = querySnapshot
                else {
                    return
                }
                self?.setPetData(querySnapshot)
            }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    loadingView.didDismissView()
                }
        }
    }

    func setPetData(_ querySnapshot: QuerySnapshot) {
        var petInformations: [PetInformation] = []
        for document in querySnapshot.documents {
            let petInfor = PetInformation()

            let data = document.data()
            petInfor.name = data["name"] as? String ?? ""
            petInfor.birthday = data["birthday"] as? String ?? ""
            petInfor.color = data["color"] as? String ?? ""
            petInfor.sex = data["sex"] as? String ?? ""
            petInfor.species = data["species"] as? String ?? ""
            petInfor.uId = data["uId"] as? String ?? ""

            if petInfor.uId == userManager.getUserInfo().uid {
                petInformations.append(petInfor)
            }
        }
        DispatchQueue.main.async {
            self.petInformations = petInformations
            self.listPetTableView?.reloadData()
        }
    }
}
