//
//  InformationPetViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 03/10/2022.
//

import UIKit

class InformationPetViewController: UIViewController {
    @IBOutlet weak var avatarPet: UIImageView?
    @IBOutlet weak var petNameLabel: UILabel?
    @IBOutlet weak var informationPetTableView: UITableView?
    @IBOutlet weak var containerView: UIView?
    
    let informationPetCell: String = "informationPetCell"
    var content: [String] = ["Date of birth", "Species", "Sex", "Color"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension InformationPetViewController {
    private func setupUI() {
        _ = view?.applyGradient()
        avatarPet?.layer.cornerRadius = (avatarPet?.frame.height ?? 100) / 2
        petNameLabel?.text = "Chos Quang"
        navigationController?.isNavigationBarHidden = false
        let editButton = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(didTapEditButton))
        navigationItem.rightBarButtonItem = editButton
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
}

extension InformationPetViewController {
    @objc
    func didTapEditButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension InformationPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        informationPetTableView?.deselectRow(at: indexPath, animated: true)
    }
}

extension InformationPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let inforPetCell = informationPetTableView?.dequeueReusableCell(
            withIdentifier: informationPetCell
        ) as? InforPetTableViewCell else {
            return InforPetTableViewCell()
        }
        inforPetCell.contentLabel?.text = content[indexPath.row]
        return inforPetCell
    }
}
