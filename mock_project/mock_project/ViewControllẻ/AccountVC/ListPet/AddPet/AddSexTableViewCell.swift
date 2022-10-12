//
//  AddSexTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 08/10/2022.
//

import UIKit

class AddSexTableViewCell: UITableViewCell {

    @IBOutlet weak var addSexTextField: UITextField?

    let sex: [String] = ["Đực", "Cái"]

    var pickerView = UIPickerView()

    override func awakeFromNib() {
        super.awakeFromNib()
        pickerView.delegate = self
        pickerView.dataSource = self
        addSexTextField?.inputView = pickerView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func didGetSex() -> String {
        let petInformation: PetInformation = PetInformation()
        petInformation.sex = addSexTextField?.text ?? ""
        return petInformation.sex ?? ""
    }
}

extension AddSexTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sex.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sex[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        addSexTextField?.text = sex[row]
        addSexTextField?.resignFirstResponder()
    }
}
