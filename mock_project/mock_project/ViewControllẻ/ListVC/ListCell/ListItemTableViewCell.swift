//
//  ListItemTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    var itemImages: [String] = ["dog1", "dog2", "dog3", "dog4"]
    var itemLabel: [String] = ["Rayan", "Labador", "Husky", "Yorke"]
    var tapCell: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self

        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension ListItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemLabel.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell", for: indexPath) as? ItemCollectionViewCell

        cell?.itemImageView?.image = UIImage(named: itemImages[indexPath.row])
        cell?.itemLabel.text = itemLabel[indexPath.row]

        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapCell()
    }
}
