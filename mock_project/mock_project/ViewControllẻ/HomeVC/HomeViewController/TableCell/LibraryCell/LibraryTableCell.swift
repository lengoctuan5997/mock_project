//
//  LibraryTableCell.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 02/10/2022.
//

import UIKit
import AVFoundation

class LibraryTableCell: UITableViewCell {

    @IBOutlet weak var libraryCollectionView: UICollectionView?
    var animals: [CGFloat] = [300, 200, 200, 300]
    var libraryTapCellClousure: () -> Void = {}
    var contentLibarary: [LibrariesContent] = [
        LibrariesContent(title: "Sổ sức khoẻ", image: "heath_care"),
        LibrariesContent(title: "Thú cưng", image: "my_pet_color"),
        LibrariesContent(title: "Cẩm nang", image: "handbook_color"),
        LibrariesContent(title: "Huấn luyện", image: "training_color")
        ]

    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - config collection view
extension LibraryTableCell {
    func configCollectionView() {
        libraryCollectionView?.register(
            UINib(
                nibName: String(describing: LibraryCell.self),
                bundle: .main
            ),
            forCellWithReuseIdentifier: "librartCell"
        )
        if let layout = libraryCollectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        libraryCollectionView?.delegate = self
        libraryCollectionView?.dataSource = self
        libraryCollectionView?.allowsSelection = true
        libraryCollectionView?.allowsMultipleSelection = true
    }
}

// MARK: - library collection delegate
extension LibraryTableCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        libraryTapCellClousure()
    }
}

// MARK: - library collection datasource
extension LibraryTableCell: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        4
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return initCell(indexPath)
    }

    func initCell(
        _ indexPath: IndexPath
    ) -> LibraryCell {
        let cell = libraryCollectionView?.dequeueReusableCell(
            withReuseIdentifier: "librartCell",
            for: indexPath
        ) as? LibraryCell ?? LibraryCell()
        cell.configUIData(contentLibarary[indexPath.row])

        return cell
    }

}

// MARK: - pinterest layout
extension LibraryTableCell: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForCellAtIndexPath indexPath: IndexPath
    ) -> CGFloat {
        animals[indexPath.item]
    }
}
