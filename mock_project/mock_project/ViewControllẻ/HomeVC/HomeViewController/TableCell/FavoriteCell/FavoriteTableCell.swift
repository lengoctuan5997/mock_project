//
//  FavoriteTableCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 02/10/2022.
//

import UIKit

class FavoriteTableCell: UITableViewCell {
    @IBOutlet weak var favoriteCollectionView: UICollectionView?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout?
    private var animalsFavorite: [String] = ["dogF", "catF"]

    var favoriteTapCellClousure: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - config collection
extension FavoriteTableCell {
    func configCollectionView() {
        favoriteCollectionView?.register(
            UINib(nibName:
                    String(describing: FavoriteCollectionCell.self),
                  bundle: .main),
            forCellWithReuseIdentifier: "favoriteCollectionCell"
        )
        favoriteCollectionView?.delegate = self
        favoriteCollectionView?.dataSource = self
        flowLayout?.scrollDirection = .horizontal
    }
}

// MARK: - collection delegate
extension FavoriteTableCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        favoriteTapCellClousure()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        shouldDeselectItemAt indexPath: IndexPath
    ) -> Bool {
        true
    }
}

// MARK: - collection datasource
extension FavoriteTableCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        animalsFavorite.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = favoriteCollectionView?.dequeueReusableCell(
            withReuseIdentifier: "favoriteCollectionCell",
            for: indexPath
        ) as? FavoriteCollectionCell ?? FavoriteCollectionCell()
        cell.configDataUI(animalsFavorite[indexPath.row])
        return cell
    }
}
