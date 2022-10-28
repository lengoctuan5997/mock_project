//
//  HandBookViewModel.swift
//  mock_project
//
//  Created by Lê Ngọc Tuấn on 25/10/2022.
//

import Foundation
import UIKit

protocol HandBookViewModelProtocol {
    func getHandBook(_ completion: @escaping (() -> Void))
}

public class HandBookViewModel: HandBookViewModelProtocol {
    
    private let loadingView: LoadingView = {
        let loadingView = LoadingView(
            nibName: "LoadingView",
            bundle: .main
        )

        loadingView.modalPresentationStyle = .overCurrentContext
        loadingView.modalTransitionStyle = .crossDissolve

        return loadingView
    }()
    private let handBookUseCase: HandBookUseCaseProtocol
    private var handBookAnimals: [HandBook] = []

    init(handBookUseCase: HandBookUseCaseProtocol) {
        self.handBookUseCase = handBookUseCase
    }

    func getHandBook(_ completion: @escaping (() -> Void)) {
        handBookUseCase.getHandBook { [weak self] result in
            switch result {
            case .success(let data):
                self?.handBookAnimals = data
                dump(data, name: "data")
                completion()
            case .failure(let error):
                print("error \(error)")
            }
        }
    }

    func didSetLoading(_ isShow:Bool) {
        
    }

    func handBooks() -> [HandBook] {
        return handBookAnimals
    }
}
