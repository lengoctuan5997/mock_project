//
//  Training.swift
//  mock_project
//
//  Created by Le on 09/10/2022.
//

import Foundation
import FirebaseFirestore

class Training {
    var animal: String?
    var description: String?
    var title: String = ""
    var image: UIImage?
    public static let shared = Training()

    func didLoadTraining(
        _ loadingView: LoadingView
    ) -> [Training] {
        let dbFirestore = Firestore.firestore()
        var trainings: [Training] = []
        dbFirestore
            .collection("training")
            .getDocuments { [weak self] (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let querySnapshot = querySnapshot
                else {
                    return
                }
                DispatchQueue.main.async {
                    trainings = self?.setData(querySnapshot) ?? []
                }
            }

            loadingView.didDismissView()
        }
        return trainings
    }

    func setData(_ querySnapshot: QuerySnapshot) -> [Training] {
        var trainings: [Training] = []
        for document in querySnapshot.documents {
            let data = document.data()
            let animal = data["animal"] as? String ?? ""
            let description = data["description"] as? String ?? ""
            let title = data["title"] as? String ?? ""

            let image = data["image"] as? String ?? ""
            let imageLink = URL(string: image) ?? URL(fileURLWithPath: "")
            let imageData = try? Data(contentsOf: imageLink)
            let imageAnimal = UIImage(data: imageData ?? Data()) as UIImage? ?? UIImage()

            let loadData = Training()
            loadData.animal = animal
            loadData.image = imageAnimal
            loadData.description = description
            loadData.title = title

            trainings.append(loadData)
        }
        print("training \(trainings.count)")
        return trainings
    }
}
