//
//  DetailCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 08/10/2022.
//

import UIKit

class DetailCell: UITableViewCell {
    @IBOutlet weak var petName: UILabel?
    @IBOutlet weak var contentPetHeath: UILabel?
    @IBOutlet weak var startTime: UILabel?
    @IBOutlet weak var addressLabel: UILabel?
    @IBOutlet weak var symptomLabel: UILabel?
    @IBOutlet weak var diagnosticLabel: UILabel?
    @IBOutlet weak var treatmentProcessLabel: UILabel?
    @IBOutlet weak var vaccinationLabel: UILabel?
    @IBOutlet weak var vacxinTypeLabel: UILabel?
    @IBOutlet weak var noteLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        petName?.text = nil
        addressLabel?.text = nil
        startTime?.text = nil
        symptomLabel?.text = nil
        treatmentProcessLabel?.text = nil
        diagnosticLabel?.text = nil
        vaccinationLabel?.text = nil
        vacxinTypeLabel?.text = nil
        noteLabel?.text = nil
        vaccinationLabel?.text = nil
        vacxinTypeLabel?.text = nil
    }

    func didSetData(_ heatBook: HeathBook) {
        DispatchQueue.main.async { [weak self] in
            self?.petName?.text = heatBook.petName
            self?.addressLabel?.text = heatBook.examinationPlace
            self?.startTime?.text = heatBook.createDate
            self?.symptomLabel?.text = heatBook.symptom
            self?.treatmentProcessLabel?.text = heatBook.treatmentProcess
            self?.diagnosticLabel?.text = heatBook.diagnostic
            self?.vaccinationLabel?.text = heatBook.vaccination ?? "--"
            self?.vacxinTypeLabel?.text = heatBook.vacxinType ?? "--"
            self?.noteLabel?.text = heatBook.note ?? "--"
        }
    }
}
