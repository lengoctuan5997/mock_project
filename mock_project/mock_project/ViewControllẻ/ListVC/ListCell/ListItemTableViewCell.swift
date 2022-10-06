//
//  ListItemTableViewCell.swift
//  mock_project
//
//  Created by Le on 03/10/2022.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout?
    
    var animals: [Animal] = []
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

        animalCollectionView.delegate = self
        animalCollectionView.dataSource = self

        let nib = UINib(
            nibName: "ItemCollectionViewCell",
            bundle: .main
        )
        animalCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        let screenWidth = UIScreen.main.bounds.size.width
        flowLayout?.itemSize = CGSize(width: screenWidth / 2 - 10, height: 250)
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
        return animals.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? ItemCollectionViewCell

        cell?.configData(animals[indexPath.row])

        return cell ?? UICollectionViewCell()
    }
}
