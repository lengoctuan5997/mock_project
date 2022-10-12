//
//  AddBirthDayTableViewCell.swift
//  mock_project
//
//  Created by Tún Nguiễn on 06/10/2022.
//

import UIKit

class AddBirthDayTableViewCell: UITableViewCell {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var birthdayLabel: UILabel!

    var birthday: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        datePicker.addTarget(self, action: #selector(didSelectDate(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc
    func didSelectDate(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        let strDate = formatter.string(from: datePicker.date)
        birthday = strDate
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func didGetBirthday() -> String {
        let petInformation: PetInformation = PetInformation()
        petInformation.birthday = birthday
        return petInformation.birthday ?? ""
    }
}
