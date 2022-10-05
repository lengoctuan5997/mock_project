//
//  CategoriesTableCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 02/10/2022.
//

import UIKit

class CategoriesTableCell: UITableViewCell {
    @IBOutlet weak var categoriesCollectionView: UICollectionView?
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout?
    @IBOutlet weak var cellView: UIView?
    var categoriesAnimal: [String] = ["cat", "bird", "dog", "fish"]
    var tapCategoriesCellClousure: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        configCategoriesCollection()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
// MARK: - config categories collection
extension CategoriesTableCell {
    func configCategoriesCollection() {
        categoriesCollectionView?.register(
            UINib(nibName: String(describing: CategoriesCell.self), bundle: .main),
            forCellWithReuseIdentifier: "categoriesCVV"
        )
        flowLayout?.scrollDirection = .horizontal
        categoriesCollectionView?.delegate = self
        categoriesCollectionView?.dataSource = self
//        cellView?.applyGradient()
    }
}

// MARK: - collection delegate
extension CategoriesTableCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        tapCategoriesCellClousure()
    }
}

// MARK: - collection datasource
extension CategoriesTableCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        categoriesAnimal.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return initCellView(indexPath)
    }

    func initCellView(
        _ indexPath: IndexPath
    ) -> CategoriesCell {
        let cell = categoriesCollectionView?.dequeueReusableCell(
            withReuseIdentifier: "categoriesCVV",
            for: indexPath
        ) as? CategoriesCell ?? CategoriesCell()
        cell.configData(categoriesAnimal[indexPath.row])

        return cell
    }
}
