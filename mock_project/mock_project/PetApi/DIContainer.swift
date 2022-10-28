//
//  DIContainer.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 25/10/2022.
//

import Foundation

public final class DIContainer {
    public static let shared = DIContainer()

    lazy var firebaseService: FireBaseServiceProtocol = {
        return FireBaseService()
    }()

    lazy var handBookUseCase: HandBookUseCaseProtocol = {
        return HandBookUseCase(firebaseService: firebaseService)
    }()
}
