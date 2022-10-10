//
//  NewPetHeathCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 09/10/2022.
//

import UIKit

class NewPetHeathCell: UITableViewCell {
    @IBOutlet weak var petNameTF: UITextField?
    @IBOutlet private weak var dayExaminationTf: UITextField?
    @IBOutlet private weak var examinationPlaceTf: UITextField!
    @IBOutlet private weak var symptomTf: UITextField?
    @IBOutlet private weak var diagnosticTF: UITextField?
    @IBOutlet private weak var vaccinTimesTf: UITextField?
    @IBOutlet private weak var vaccinTypeTF: UITextField?
    @IBOutlet private weak var processTF: UITextView?
    @IBOutlet private weak var noteTF: UITextView?

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func didGetData() -> HeathBook {
        let heathBook: HeathBook = HeathBook()

        heathBook.vacxinType = vaccinTypeTF?.text ?? ""
        heathBook.vaccination = vaccinTimesTf?.text ?? ""
        heathBook.petName = petNameTF?.text ?? ""
        heathBook.note = noteTF?.text ?? ""
        heathBook.treatmentProcess = processTF?.text ?? ""
        heathBook.createDate = dayExaminationTf?.text ?? ""
        heathBook.diagnostic = diagnosticTF?.text ?? ""
        heathBook.symptom = symptomTf?.text ?? ""
        heathBook.examinationPlace = examinationPlaceTf.text

        return heathBook
    }
}

// MARK: - config UI
extension NewPetHeathCell {
    func configUI() {
        vaccinTypeTF?.setTextFieldStyle()
        vaccinTimesTf?.setTextFieldStyle()
        petNameTF?.setTextFieldStyle()
        dayExaminationTf?.setTextFieldStyle()
        diagnosticTF?.setTextFieldStyle()
        symptomTf?.setTextFieldStyle()
        examinationPlaceTf?.setTextFieldStyle()

        noteTF?.setBorder(1, .primaryColor)
        processTF?.setBorder(1, .primaryColor)
        noteTF?.cardShadow()
        processTF?.cardShadow()
        noteTF?.layer.cornerRadius = 15
        processTF?.layer.cornerRadius = 15
    }
}
