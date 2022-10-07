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

    private var itemLabel: [String] = ["Rayan", "Labador", "Husky", "Yorke"]
    var tapCell: (_ indexPath: IndexPath) -> Void = {_ in}
    var animals: [Animal] = []

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
// MARK: - SET DATA
extension ListItemTableViewCell {
    func setData(_ animals: [Animal]) {
        self.animals = animals
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
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
        tapCell(indexPath)
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
