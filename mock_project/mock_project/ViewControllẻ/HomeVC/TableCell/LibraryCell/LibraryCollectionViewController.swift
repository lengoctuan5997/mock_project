//
//  LibraryCollectionViewController.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    var animals: [CGFloat] = [200, 150, 150, 200]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.cardShadow()
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 10, bottom: 10, right: 10)

        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            collectionView.register(
                UINib(
                    nibName: String(describing: LibraryCell.self),
                    bundle: .main),
                forCellWithReuseIdentifier: "libraryCollectionCell"
            )
            layout.delegate = self
        }
    }
}

extension LibraryCollectionViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCollectionCell", for: indexPath)
        return cell
    }
}

// MARK: - pinterest layout delegate
extension LibraryCollectionViewController: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForCellAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        return animals[indexPath.item]
    }
}
