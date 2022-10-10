//
//  ListPetViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 05/10/2022.
//

import UIKit

class ListPetViewController: UIViewController {
    @IBOutlet weak var listPetTableView: UITableView?

    let logoCell: String = "logoListCell"
    let listCell: String = "listPetCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
                    describing: LogoListTableViewCell.self
                ),
                bundle: nil
            ),
            forCellReuseIdentifier: logoCell)
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
        switch indexPath.row {
        case 0:
            break
        default:
            navigationController?.pushViewController(InformationPetViewController(), animated: true)
        }
        listPetTableView?.deselectRow(at: indexPath, animated: true)
    }
}

extension ListPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = listPetTableView?.dequeueReusableCell(
            withIdentifier: listCell) as? ListPetTableViewCell else {
            return ListPetTableViewCell()
        }
        return listCell
    }
}
