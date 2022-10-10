//
//  NewPetHeathVC.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 08/10/2022.
//

import UIKit
import FirebaseFirestore

class NewPetHeathVC: UIViewController {
    @IBOutlet weak var newPetHeath: UITableView?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var saveButton: UIButton?

    let identifiCell: String = "newPetHeathCell"
    var petHeath: HeathBook?
    private let userManager = UserManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    @IBAction func didBackPrevView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func didSave(_ sender: Any) {
        didAddNewPetHeath()
    }
}

// MARK: - config UI
extension NewPetHeathVC {
    func configUI() {
        _ = view.applyGradient()
        backButton?.setStyleBackButton()
        saveButton?.setStyleBackButton()

        newPetHeath?.register(
            UINib(
                nibName: "NewPetHeathCell",
                bundle: .main
            ),
            forCellReuseIdentifier: identifiCell
        )
        newPetHeath?.delegate = self
        newPetHeath?.dataSource = self
    }
}

// MARK: - delegate
extension NewPetHeathVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - datasource
extension NewPetHeathVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newPetHeath?.dequeueReusableCell(
            withIdentifier: identifiCell,
            for: indexPath
        ) as? NewPetHeathCell ?? NewPetHeathCell()

        return cell
    }
}

// MARK: - event add new pet heath
extension NewPetHeathVC {
    func didAddNewPetHeath() {
        // let ramdom: String = randomString(length: 6)
        let newPetHeathCell = newPetHeath?.cellForRow(at: IndexPath(row: 0, section: 0)) as? NewPetHeathCell

        let data: HeathBook = newPetHeathCell?.didGetData() ?? HeathBook()
        guard let petName = data.petName else { return }
        guard let examinationPlace = data.examinationPlace else { return }
        guard let symptom = data.symptom else { return }
        guard let createDate = data.createDate else { return }
        guard let diagnostic = data.diagnostic else { return }
        guard let note = data.note else { return }
        guard let vaccination = data.vaccination else { return }
        guard let vacxinType = data.vacxinType else { return }
        guard let treatmentProcess = data.treatmentProcess else { return }

        let dbFirestore = Firestore.firestore()

        dbFirestore.collection("heathBook").addDocument(data: [
            "petName": petName,
            "examinationPlace": examinationPlace,
            "symptom": symptom,
            "createDate": createDate,
            "diagnostic": diagnostic,
            "note": note,
            "vaccination": vaccination,
            "vacxinType": vacxinType,
            "treatmentProcess": treatmentProcess,
            "uId": userManager.getUserInfo().uid ?? ""
        ]) { [weak self] (error) in
            if error != nil {
                print("error \(String(describing: error))")
            } else {
                self?.navigationController?.popViewController(animated: true)
                print("Successfully")
            }
//            loadingView.didDismissView()
        }
    }

    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map { _ in letters.randomElement()! })
    }
}
