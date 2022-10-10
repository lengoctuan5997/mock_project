//
//  HandBook.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 08/10/2022.
//

import Foundation
import UIKit
import FirebaseFirestore

class HandBook {
    var animal: String?
    var description: String?
    var title: String = ""
    var image: UIImage?
    public static let shared = HandBook()

    func didLoadHandBook(
        _ loadingView: LoadingView
    ) -> [HandBook] {
        let dbFirestore = Firestore.firestore()
        var handBooks: [HandBook] = []
        dbFirestore
            .collection("petLibrary")
            .getDocuments { [weak self] (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let querySnapshot = querySnapshot
                else {
                    return
                }
                DispatchQueue.main.async {
                    handBooks = self?.setData(querySnapshot) ?? []
                }
            }

            loadingView.didDismissView()
        }
        return handBooks
    }

    func setData(_ querySnapshot: QuerySnapshot) -> [HandBook] {
        var handBooks: [HandBook] = []
        for document in querySnapshot.documents {
            let data = document.data()
            let animal = data["animal"] as? String ?? ""
            let description = data["description"] as? String ?? ""
            let title = data["title"] as? String ?? ""

            let image = data["image"] as? String ?? ""
            let imageLink = URL(string: image) ?? URL(fileURLWithPath: "")
            let imageData = try? Data(contentsOf: imageLink)
            let imageAnimal = UIImage(data: imageData ?? Data()) as UIImage? ?? UIImage()

            let loadData = HandBook()
            loadData.animal = animal
            loadData.image = imageAnimal
            loadData.description = description
            loadData.title = title

            handBooks.append(loadData)
        }
        print("handbook \(handBooks.count)")
        return handBooks
    }
}
