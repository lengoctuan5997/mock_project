//
//  FireBaseService.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 24/10/2022.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import FirebaseFunctions

protocol FireBaseServiceProtocol {
//    var auth: Auth { get }
    var firestore: Firestore { get }
//    var storage: Storage { get }
//    var function: Functions { get }
    
    func getHandBook(_ completion: @escaping ((Result<[HandBook], Error>) -> Void))
    
}

public final class FireBaseService: FireBaseServiceProtocol {

    lazy var firestore: Firestore = {
        return Firestore.firestore()
    }()

//    lazy var function: Functionss = {
//        return Functions.functions()
//    }

    private lazy var handBooks: CollectionReference = {
        return firestore.collection(FireBaseName.training)
    }()

    func getHandBook(_ completion: @escaping ((Result<[HandBook], Error>) -> Void)) {
        handBooks
            .getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let result: [HandBook] = snapshot?.documents.compactMap { document -> HandBook? in
                    do {
                        let res = document.data()
                        let content = HandBook()
                        content.animal = res["animal"] as? String
                        content.description = res["description"] as? String
                        content.title = res["title"] as? String ?? ""
                        content.image = res["image"] as? String ?? ""
                        return content
                    } catch {
                        debugPrint(error)
                        return nil
                    }
                } ?? []
                completion(.success(result))
            }
        }
    }
}
