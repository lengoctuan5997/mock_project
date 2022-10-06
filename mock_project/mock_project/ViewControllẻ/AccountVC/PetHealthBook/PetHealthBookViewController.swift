//
//  PetHealthBookViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 04/10/2022.
//

import UIKit

class PetHealthBookViewController: UIViewController {
    @IBOutlet weak var avatarPet: UIImageView?
    @IBOutlet weak var petNameHealthBookLabel: UILabel?
    @IBOutlet weak var healthBookTableView: UITableView?

    let healthBookCell: String = "healthBookCell"
    var contentHealthBook: [String] = ["Ngày khám", "Triệu chứng", "Chuẩn đoán tình trạng", "Nơi khám"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension PetHealthBookViewController {
    private func setupUI() {
        avatarPet?.layer.cornerRadius = (avatarPet?.frame.height ?? 100) / 2
        petNameHealthBookLabel?.text = "Chos Quang"
        navigationController?.isNavigationBarHidden = false
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = addButton
        healthBookTableView?.delegate = self
        healthBookTableView?.dataSource = self
        healthBookTableView?.register (
            UINib(
                nibName: String (
                    describing: HealthBookTableViewCell.self
                ),
                bundle: nil
            ),
            forCellReuseIdentifier: healthBookCell
        )
    }
}

extension PetHealthBookViewController {
    @objc
    func didTapAddButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension PetHealthBookViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        healthBookTableView?.deselectRow(at: indexPath, animated: true)
    }
}

extension PetHealthBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentHealthBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let healthBookCell = healthBookTableView?.dequeueReusableCell(withIdentifier: healthBookCell) as? HealthBookTableViewCell else {
            return HealthBookTableViewCell()
        }
        healthBookCell.contentHealthBookLabel?.text = contentHealthBook[indexPath.row]
        return healthBookCell
    }
    
    
}
