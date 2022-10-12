//
//  FavoriteTableCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 02/10/2022.
//

import UIKit
import CoreData

class FavoriteTableCell: UITableViewCell {
    @IBOutlet weak var favoriteCollectionView: UICollectionView?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout?
    @IBOutlet weak var noDataView: UIView?
    private var animalsFavorite: [NSManagedObject] = []

    var favoriteTapCellClousure: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        getFavorite()
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
        favoriteCollectionView?.contentInset = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: -10)
        favoriteCollectionView?.delegate = self
        favoriteCollectionView?.dataSource = self
        flowLayout?.scrollDirection = .horizontal

        animalsFavorite = Favorite.getFavoriteOfCurrentUser()
        noDataView?.isHidden = animalsFavorite.count > 0 ? true : false
    }

    func getFavorite() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateFavorite),
            name: Notification.Name.notiFicationNameFavorite,
            object: nil
        )
    }

    @objc
    func didUpdateFavorite() {
        animalsFavorite = Favorite.getFavoriteOfCurrentUser()
        noDataView?.isHidden = animalsFavorite.count > 0 ? true : false
        favoriteCollectionView?.reloadData()
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

        let imageData = animalsFavorite[indexPath.item].value(forKey: "image") as? Data ?? Data()
    
        cell.configDataUI(imageData)
        return cell
    }
}
