//
//  ListItemTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView?

    var animals: [String] = ["dog_f1", "dog_f2", "dog_f3", "dog_f4"]
    var itemLabel: [String] = ["Rayan", "Labador", "Husky", "Yorke"]
    var tapCell: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    override func setSelected(
        _ selected: Bool,
        animated: Bool
    ) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - config UI
extension ListItemTableViewCell {
    func configUI() {
        guard let animalCollectionView = collectionView
        else {
            return
        }

        if let layout = animalCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        animalCollectionView.delegate = self
        animalCollectionView.dataSource = self

        let nib = UINib(
            nibName: "ItemCollectionViewCell",
            bundle: .main
        )
        animalCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
    }
}
// MARK: - collection view delegate
extension ListItemTableViewCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("tap tap")
        tapCell()
    }
}
extension ListItemTableViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return itemLabel.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? ItemCollectionViewCell

        cell?.animalImageView?.image = UIImage(named: animals[indexPath.row])
        cell?.animalLabel?.text = itemLabel[indexPath.row]

        return cell ?? UICollectionViewCell()
    }
}

// MARK: - pinterest layout
extension ListItemTableViewCell: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForCellAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        guard let height = UIImage(named: animals[indexPath.item])?.size.height else {
            return 0
        }
        return height
    }
}
