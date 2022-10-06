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
        self.navigationController?.isNavigationBarHidden = false
        let addPetButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddPetButton))
        navigationItem.rightBarButtonItem = addPetButton
        listPetTableView?.delegate = self
        listPetTableView?.dataSource = self
        listPetTableView?.register (
            UINib(
                nibName: String (
                    describing: LogoListTableViewCell.self
                ),
                bundle: nil
            ),
            forCellReuseIdentifier: logoCell)
        listPetTableView?.register (
            UINib(
                nibName: String (
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
        140
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
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let logoCell = listPetTableView?.dequeueReusableCell(withIdentifier: logoCell) as? LogoListTableViewCell else {
                return LogoListTableViewCell()
            }
            return logoCell
        default:
            guard let listCell = listPetTableView?.dequeueReusableCell(withIdentifier: listCell) as? ListPetTableViewCell else {
                return ListPetTableViewCell()
            }
            return listCell
        }
    }
    
    
}
