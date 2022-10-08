//
//  SearchTableCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import UIKit

class SearchTableCell: UITableViewCell {
    @IBOutlet weak var searchView: UIView?
    @IBOutlet weak var searchTextField: UITextField?
    var deleteSearchValueClousure: () -> Void = {}
    var didStartSearchClousure: (_ searchValue: String) -> Void = {_ in}
    @IBOutlet weak var deleteButton: UIButton!
    private var timer: Timer?

    override func awakeFromNib() {
        super.awakeFromNib()
        searchView?.cardShadow()
        searchView?.setBorder(1, .primaryColor)
        searchView?.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func didTapRemoveText(_ sender: Any) {
        searchTextField?.text = nil
        deleteSearchValueClousure()
        deleteButton.isHidden = true
    }

    @IBAction func didStartSearch(_ sender: Any) {
        deleteButton.isHidden = false
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(onSearch),
            userInfo: nil,
            repeats: false
        )
    }

    @objc
    func onSearch() {
        didStartSearchClousure(searchTextField?.text ?? "")
    }
}
