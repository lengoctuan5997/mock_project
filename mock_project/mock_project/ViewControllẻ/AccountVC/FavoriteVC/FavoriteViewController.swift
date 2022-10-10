//
//  FavoriteViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 04/10/2022.
//

import UIKit

private let reuseIdentifier = "favoriteCell"

class FavoriteViewController: UICollectionViewController {
    @IBOutlet var collectionContainer: UICollectionView!

    var animalFavorites: [String] = ["dog_f1", "dog_f2", "dog_f3", "dog_f4", "dog_f5", "dog_f6", "dog_f7"]

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
}
extension FavoriteViewController {
    func configUI() {
        view.backgroundColor = .white
        _ = view.applyGradient()

        collectionView.register(
            UINib(
                nibName: String(describing: FavoriteCell.self),
                bundle: .main
            ),
            forCellWithReuseIdentifier: reuseIdentifier
        )
        collectionView.contentInset = UIEdgeInsets(
            top: 20,
            left: 5,
            bottom: 10,
            right: 5
        )

        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }
}

extension FavoriteViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return animalFavorites.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? FavoriteCell ?? FavoriteCell()

        cell.configData(animalFavorites[indexPath.item])

        return cell
    }
}

extension FavoriteViewController: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForCellAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        guard let height = UIImage(named: animalFavorites[indexPath.item])?.size.height else {
            return 0
        }
        return height
    }
}
