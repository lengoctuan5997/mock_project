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
    var collectionHeight: CGFloat {
        return libraryCollectionView?.frame.size.height ?? 0
    }
    var animals: [CGFloat] = [250, 180, 180, 250]
    let itemsPerRow: Int = 2
    let sectionInsets: UIEdgeInsets = UIEdgeInsets(
        top: 10,
        left: 5,
        bottom: 5,
        right: 5
    )
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
        libraryCollectionView?.delegate = self
        libraryCollectionView?.dataSource = self
    }
}

// MARK: - library collection delegate
extension LibraryTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
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
        cell.configUIData(["catF", "dogF", "catF", "dogF"][indexPath.row])

        print(indexPath.row)
        if indexPath.row == 2 {
            cell.handBookClousure = { [weak self] in
                NotificationCenter.default.post(
                    name: NSNotification.Name.notiFicationNameHandBook,
                    object: nil
                )
            }
        }
        return cell
    }

}

// MARK: - flowlay out delegate
extension LibraryTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availabelWith = collectionView.frame.width - paddingSpace
        let withPerItem = availabelWith / CGFloat(itemsPerRow)

        let boundingRect = CGRect(
            x: 0,
            y: 0,
            width: withPerItem,
            height: CGFloat.greatestFiniteMagnitude
        )
        let react = AVMakeRect(
            aspectRatio: (UIImage(named: ["catF", "dogF", "catF", "dogF"][indexPath.row])?.size)!,
            insideRect: boundingRect
        )

        return CGSize(width: withPerItem, height: animals[indexPath.row])
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        sectionInsets.left
    }
}
