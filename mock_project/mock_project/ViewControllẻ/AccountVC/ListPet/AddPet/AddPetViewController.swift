//
//  AddPetViewController.swift
//  mock_project
//
//  Created by Tún Nguiễn on 05/10/2022.
//

import UIKit
import FirebaseFirestore

class AddPetViewController: UIViewController {
    @IBOutlet weak var addPetTableView: UITableView?

    let addPhotoPetCellId: String = "addPhotoPetCell"
    let addNamePetCellId: String = "addNamePetCell"
    let addBirthdayCellId: String = "addBirthdayCell"
    let addSpeciesCellId: String = "addSpeciesCell"
    let addSexCellId: String = "addSexCell"
    let addColorCellId: String = "addColorCell"
    
    var myPet = PetInformation()

    let datePicker = UIDatePicker()
    let picker = UIImagePickerController()
    private let userManager = UserManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
}

extension AddPetViewController {
    private func setupUI() {
        _ = view.applyGradient()
        setupToHideKeyboardOnTapOnView()
        self.navigationController?.isNavigationBarHidden = false
        let doneAddPetButton = UIBarButtonItem(title: "Xong", style: .done, target: self, action: #selector(didTapDoneAddPetButton))
        navigationItem.rightBarButtonItem = doneAddPetButton
        addPetTableView?.delegate = self
        addPetTableView?.dataSource = self
        addPetTableView?.register (
            UINib (
                nibName: String (
                    describing: AddAvatarPetTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addPhotoPetCellId
        )
        addPetTableView?.register (
            UINib (
                nibName: String (
                    describing: AddBirthDayTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addBirthdayCellId
        )
        addPetTableView?.register (
            UINib (
                nibName: String (
                    describing: AddNamePetTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addNamePetCellId
        )
        addPetTableView?.register (
            UINib (
                nibName: String (
                    describing: AddSpeciesTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addSpeciesCellId
        )
        addPetTableView?.register (
            UINib (
                nibName: String (
                    describing: AddSexTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addSexCellId
        )
        addPetTableView?.register (
            UINib (
                nibName: String (
                    describing: AddColorTableViewCell.self
                ),
                bundle: nil
            ), forCellReuseIdentifier: addColorCellId
        )
    }
}

extension AddPetViewController {
    @objc
    func didTapDoneAddPetButton() {
                let newNamePetCell = addPetTableView?.cellForRow(at: IndexPath(row: 1, section: 0)) as? AddNamePetTableViewCell
                let newSpeciesPetCell = addPetTableView?.cellForRow(at: IndexPath(row: 2, section: 0)) as? AddSpeciesTableViewCell
                let newBirthdayPetCell = addPetTableView?.cellForRow(at: IndexPath(row: 3, section: 0)) as? AddBirthDayTableViewCell
                let newSexPetCell = addPetTableView?.cellForRow(at: IndexPath(row: 4, section: 0)) as? AddSexTableViewCell
                let newColorPetCell = addPetTableView?.cellForRow(at: IndexPath(row: 5, section: 0)) as? AddColorTableViewCell

        let nameData: String = newNamePetCell?.didGetName() ?? PetInformation().name ?? ""
        let speciesData: String = newSpeciesPetCell?.didGetSpecies() ?? PetInformation().species ?? ""
        let birthdayData: String = newBirthdayPetCell?.didGetBirthday() ?? PetInformation().birthday ?? ""
        let sexData: String = newSexPetCell?.didGetSex() ?? PetInformation().sex ?? ""
        let colorData: String = newColorPetCell?.didGetColor() ?? PetInformation().color ?? ""

                let dbFirestore = Firestore.firestore()

                dbFirestore.collection("myPet").addDocument(data: [
                    "name": nameData,
                    "sex": sexData,
                    "color": colorData,
                    "birthday": birthdayData,
                    "species": speciesData,
                    "uId": userManager.getUserInfo().uid ?? ""
                ]) { [weak self] (error) in
                    if error != nil {
                        print("error \(String(describing: error))")
                    } else {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
    }
}

extension AddPetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addPetTableView?.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 150
        case 2:
            return 250
        default:
            return 80
        }
    }
}

extension AddPetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let addPhotoPetCell = addPetTableView?.dequeueReusableCell(withIdentifier: addPhotoPetCellId) as? AddAvatarPetTableViewCell else {
                return AddAvatarPetTableViewCell()
            }
            addPhotoPetCell.pickerClosure = { [weak self] in
                self?.picker.sourceType = .photoLibrary
                self?.picker.delegate = self
                self?.picker.allowsEditing = true
                self?.present(self?.picker ?? UIImagePickerController(), animated: true)
            }
            return addPhotoPetCell
        case 1:
            guard let addNamePetCell = addPetTableView?.dequeueReusableCell(withIdentifier: addNamePetCellId) as? AddNamePetTableViewCell else {
                return AddNamePetTableViewCell()
            }
            return addNamePetCell
        case 2:
            guard let addSpeciesCell = addPetTableView?.dequeueReusableCell(withIdentifier: addSpeciesCellId) as? AddSpeciesTableViewCell else {
                return AddSpeciesTableViewCell()
            }
            return addSpeciesCell
        case 3:
            guard let addBirthdayCell = addPetTableView?.dequeueReusableCell(withIdentifier: addBirthdayCellId) as? AddBirthDayTableViewCell else {
                return AddBirthDayTableViewCell()
            }
            return addBirthdayCell
        case 4:
            guard let addSexCell = addPetTableView?.dequeueReusableCell(withIdentifier: addSexCellId) as? AddSexTableViewCell else {
                return AddSexTableViewCell()
            }
            return addSexCell
        default:
            guard let addColorCell = addPetTableView?.dequeueReusableCell(withIdentifier: addColorCellId) as? AddColorTableViewCell else {
                return AddColorTableViewCell()
            }
            return addColorCell
        }
    }
}

extension AddPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        let addAvatarCell = AddAvatarPetTableViewCell()
        addAvatarCell.avatarPet?.image = image
        self.picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker.dismiss(animated: true, completion: nil)
    }
}
