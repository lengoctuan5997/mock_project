//
//  AddPetViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 05/10/2022.
//

import UIKit

class AddPetViewController: UIViewController {
    @IBOutlet weak var addPetTableView: UITableView?

    let addPhotoPetCell: String = "addPhotoPetCell"
    let addInforPetCell: String = "addInforPetCell"

    let titleAdd: [String] = ["Tên thú cưng", "Ngày sinh", "Loài thú cưng", "Giới tính", "Màu thú cưng"]
    let datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension AddPetViewController {
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = false
        let doneAddPetButton = UIBarButtonItem(
            title: "Xong",
            style: .done,
            target: self, action: #selector(didTapDoneAddPetButton)
        )
        navigationItem.rightBarButtonItem = doneAddPetButton
        addPetTableView?.delegate = self
        addPetTableView?.dataSource = self
        addPetTableView?.register(
            UINib(
                nibName: String(
                    describing: AddAvatarPetTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addPhotoPetCell
        )
        addPetTableView?.register(
            UINib(
                nibName: String(
                    describing: AddInformationPetTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addInforPetCell
        )
    }
}

extension AddPetViewController {
    @objc
    func didTapDoneAddPetButton() {
        dismiss(animated: true)
    }
}

extension AddPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addPetTableView?.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
}

extension AddPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let addPhotoPetCell = addPetTableView?.dequeueReusableCell(
                withIdentifier: addPhotoPetCell) as? AddAvatarPetTableViewCell
            else {
                return AddAvatarPetTableViewCell()
            }
            return addPhotoPetCell
        default:
            guard let addInforPetCell = addPetTableView?.dequeueReusableCell(
                withIdentifier: addInforPetCell) as? AddInformationPetTableViewCell
            else {
                return AddInformationPetTableViewCell()
            }
            addInforPetCell.titleLabel?.text = titleAdd[indexPath.row]
            switch indexPath.row {
            case 1:
                let toolbar = UIToolbar()
                toolbar.sizeToFit()

                let doneButton = UIBarButtonItem(title: "Xong",
                style: .done, target: self, action: #selector(didTapDonePickDate))
                toolbar.setItems([doneButton], animated: true)

                addInforPetCell.detailTextField?.inputAccessoryView = toolbar
                addInforPetCell.detailTextField?.inputView = datePicker
                addInforPetCell.detailTextField?.text = "\(datePicker.date)"
            default:
                break
            }
            return addInforPetCell
        }
    }
}

extension AddPetViewController {
    @objc
    func didTapDonePickDate() {
        self.view.endEditing(true)
    }
}
