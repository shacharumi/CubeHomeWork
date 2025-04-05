//
//  NoFriendViewModel.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/3.
//

import UIKit
import SnapKit

class NoFriendViewModel {
    var personData: [Response]?
    let categories = ["好友", "聊天"]
    var onPersonDataUpdated: (([Response]) -> Void)?
    private let personURL = "https://dimanyen.github.io/man.json"

    init() {
        fetchPersonData()
    }
    
    func fetchPersonData() {
        ApiManager.shared.getApiData(personURL, type: PersonData.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let personData):
                    self?.personData = personData.response
                    self?.onPersonDataUpdated?(personData.response)
                case .failure(let error):
                    print("Error fetchPersonData: \(error)")
                }
            }
        }
    }
}


