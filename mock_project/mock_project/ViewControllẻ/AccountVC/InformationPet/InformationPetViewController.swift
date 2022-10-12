//
//  InformationPetViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 03/10/2022.
//

import UIKit

class InformationPetViewController: UIViewController {
    @IBOutlet weak var informationPetTableView: UITableView?

    let informationPetCell: String = "informationPetCell"
    private var petInformation = PetInformation()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension InformationPetViewController {
    private func setupUI() {
        _ = view.applyGradient()
        navigationController?.isNavigationBarHidden = false
        informationPetTableView?.delegate = self
        informationPetTableView?.dataSource = self
        informationPetTableView?.register(
            UINib(
                nibName: String(
                    describing: InforPetTableViewCell.self
                ),
                bundle: nil
            ),
            forCellReuseIdentifier: informationPetCell
        )
    }

    func setPetInfor(_ petInformation: PetInformation) {
        self.petInformation = petInformation
    }
}

extension InformationPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        informationPetTableView?.deselectRow(at: indexPath, animated: true)
    }
}

extension InformationPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = informationPetTableView?.dequeueReusableCell(
            withIdentifier: informationPetCell,
            for: indexPath
        ) as? InforPetTableViewCell ?? InforPetTableViewCell()
            cell.didSetData(self.petInformation)
        return cell
    }

}
