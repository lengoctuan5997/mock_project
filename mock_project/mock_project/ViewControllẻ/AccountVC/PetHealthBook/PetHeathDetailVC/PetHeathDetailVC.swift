//
//  PetHeathDetailVC.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 08/10/2022.
//

import UIKit

class PetHeathDetailVC: UIViewController {
    @IBOutlet private weak var petHeathTableView: UITableView?
    @IBOutlet private weak var backButton: UIButton?

    private let identifiCell: String = "heathCell"
    private var heathBook: HeathBook?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    @IBAction func didBackView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
// MARK: - CONFIG UI
extension PetHeathDetailVC {
    func configUI() {
        backButton?.setStyleBackButton()
        _ = view.applyGradient()
        petHeathTableView?.cardShadow()

        petHeathTableView?.register(
            UINib(
                nibName: String(describing: DetailCell.self),
                bundle: .main
            ),
            forCellReuseIdentifier: identifiCell
        )
        petHeathTableView?.delegate = self
        petHeathTableView?.dataSource = self
    }

    func setHeathBook(_ heathBook: HeathBook) {
        self.heathBook = heathBook
        petHeathTableView?.reloadData()
    }
}

// MARK: - DELEGATE
extension PetHeathDetailVC: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        shouldHighlightRowAt indexPath: IndexPath
    ) -> Bool {
        false
    }
}

// MARK: - DATASOURCE
extension PetHeathDetailVC: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        1
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petHeathTableView?.dequeueReusableCell(
            withIdentifier: identifiCell,
            for: indexPath
        ) as? DetailCell ?? DetailCell()
        cell.didSetData(heathBook ?? HeathBook())
        return cell
    }
}
