//
//  HandBookUseCase.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 25/10/2022.
//

import Foundation

protocol HandBookUseCaseProtocol {
    func getHandBook(_ completion: @escaping ((Result<[HandBook], Error>) -> Void)) 
}

final class HandBookUseCase: HandBookUseCaseProtocol {

    private let firebaseService: FireBaseServiceProtocol

    init(firebaseService: FireBaseServiceProtocol) {
        self.firebaseService = firebaseService
    }

    func getHandBook(_ completion: @escaping ((Result<[HandBook], Error>) -> Void)) {
        firebaseService.getHandBook(completion)
    }
}
