//
//  PinterestLayout.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 03/10/2022.
//

import Foundation
import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForCellAtIndexPath indexPath: IndexPath
    ) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
    // pinterest delegate
    weak var delegate: PinterestLayoutDelegate?

    // configurable properties
    fileprivate var numberOfColumns = 2
    fileprivate var cellPadding: CGFloat = 6

    // array to keep a cache of attributes
    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    // content height and size
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(
            width: contentWidth,
            height: contentHeight
        )
    }

    override func prepare() {
        // only calc once
        guard
            cache.isEmpty == true,
            let collectionView = collectionView else {
            return
        }
        /* Pre-cacla the x offset for every column and
         adds an array to increment the currently max y
         offset for each column */
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset = [CGFloat]()

        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * contentWidth)
        }

        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

        // iterates through the lít of items in the first section
        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath: IndexPath = IndexPath(item: item, section: 0)

            /* asks the delegate for the height of the
             block and the animation and calc
             the cell frame */
            guard let blockHeight = delegate?.collectionView(
                collectionView,
                heightForCellAtIndexPath: indexPath
            ) else {
                return
            }
            let height = cellPadding * 2 + blockHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)

            /* create an UICollectionViewLayoutItem
             with the frame and add it to the cache */
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            // update the collection view content height
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height

            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }

    override func layoutAttributesForElements(
        in rect: CGRect
    ) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAtteibutes = [UICollectionViewLayoutAttributes]()

        // lop through the cache and look for items in the react
        for attributes in cache
        where attributes.frame.intersects(rect) {
            visibleLayoutAtteibutes.append(attributes)
        }
        return visibleLayoutAtteibutes
    }

    override func layoutAttributesForItem(
        at indexPath: IndexPath
    ) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

}
