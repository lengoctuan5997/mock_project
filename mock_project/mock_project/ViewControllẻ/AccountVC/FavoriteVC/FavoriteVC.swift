//
//  FavoriteVC.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 07/10/2022.
//

import UIKit
import CoreData

private let reuseIdentifier = "favoriteCell"

class FavoriteVC: UIViewController {
    @IBOutlet private weak var favoriteCollectionView: UICollectionView?
    @IBOutlet private weak var backButton: UIButton?

    private var favorites: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        initData()
    }

    @IBAction func didTapBackToPreView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CONFIG UI
extension FavoriteVC {
    func configUI() {
        tabBarController?.tabBar.isHidden = true
        guard let favoriteCollectionView = favoriteCollectionView else {
            return
        }

        backButton?.setStyleBackButton()
        backButton?.titleLabel?.textColor = .white

        view.backgroundColor = .white
        _ = view.applyGradient()

        favoriteCollectionView.register(
            UINib(
                nibName: String(describing: FavoriteCell.self),
                bundle: .main
            ),
            forCellWithReuseIdentifier: reuseIdentifier
        )
        favoriteCollectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 5,
            bottom: 10,
            right: 5
        )
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self

        if let layout = favoriteCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }

    func initData() {
        favorites = Favorite.getFavoriteOfCurrentUser()
    }
}
// MARK: - DELEGATE
extension FavoriteVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailItemViewController(
            nibName: String(describing: DetailItemViewController.self),
            bundle: .main
        )

        let favorite = favorites[indexPath.item]
        let imageData = favorites[indexPath.item].value(forKey: "image") as? Data ?? Data()
        guard let image = UIImage(data: imageData) else { return }

        let animal = Animal(
            height: favorite.value(forKey: "height") as? String ?? "",
            weight: favorite.value(forKey: "weight") as? String ?? "",
            age: favorite.value(forKey: "age") as? String ?? "",
            origin: favorite.value(forKey: "origin") as? String ?? "",
            type: favorite.value(forKey: "type") as? String ?? "",
            species: favorite.value(forKey: "species") as? String ?? "",
            information: favorite.value(forKey: "information") as? String ?? "",
            history: favorite.value(forKey: "history") as? String ?? "",
            image: image,
            animal: favorite.value(forKey: "animal") as? String ?? ""
        )

        detailVC.setAnimal(animal)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
// MARK: - DATASOURCE
extension FavoriteVC: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        favorites.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath
        ) as? FavoriteCell ?? FavoriteCell()

        let imageData = favorites[indexPath.item].value(forKey: "image") as? Data ?? Data()

        cell.configData(imageData)

        cell.unsaveFavoriteClousure = { [weak self] in
            _ = Favorite.deleteFavorite(self?.favorites[indexPath.row] ?? Favorite())
            self?.initData()
            self?.favoriteCollectionView?.deleteItems(at: [IndexPath(row: indexPath.item, section: 0)])

            NotificationCenter.default.post(name: NSNotification.Name.notiFicationNameFavorite, object: nil)
        }

        return cell
    }
}
// MARK: - PINTEREST LAYOUT
extension FavoriteVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForCellAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        let imageData = favorites[indexPath.item].value(forKey: "image") as? Data ?? Data()
        guard let height = UIImage(data: imageData)?.size.height else {
            return 0
        }
        print(height)
        return height
    }
}
