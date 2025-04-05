//
//  OnlyFriendListViewModel.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/3.
//

import Foundation

class OnlyFriendListViewModel {

    private let friendURLs = [
        "https://dimanyen.github.io/friend1.json",
        "https://dimanyen.github.io/friend2.json"
    ]
    
    private let personURL = "https://dimanyen.github.io/man.json"
    
    var categories: [String] = ["好友", "聊天"]
    
    var personData: [Response]?
    var friendListData: [FriendListDetail] = []
    private var currentPage = 0
    private let pageSize = 20
    private var allFetchedFriends: [FriendListDetail] = []
    
    var onFriendListDataUpdated: (([FriendListDetail]) -> Void)?
    var onPersonDataUpdated: (([Response]) -> Void)?

    init() {
        fetchPersonData()
    }

    func fetchPersonData() {
        ApiManager.shared.getApiData(personURL, type: PersonData.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.personData = data.response
                    self?.onPersonDataUpdated?(data.response)
                case .failure(let error):
                    print("error: fetchPersonData \(error)")
                }
            }
        }
    }

    func refreshFriendList() {
        currentPage = 0
        fetchFriendList()
    }

    func fetchFriendList() {
        let dispatchGroup = DispatchGroup()
        var fetchedFriends: [FriendListDetail] = []

        for url in friendURLs {
            dispatchGroup.enter()
            ApiManager.shared.getApiData(url, type: FriendList.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        fetchedFriends.append(contentsOf: data.response)
                    case .failure(let error):
                        print("error: fetchFriendList \(url): \(error)")
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            let merged = self.mergeFriendList(fetchedFriends)
            self.allFetchedFriends = merged
            self.loadMoreFriendList() 
        }
    }

    func loadMoreFriendList() {
        let start = currentPage * pageSize
        let end = min(start + pageSize, allFetchedFriends.count)
        guard start < end else {
            onFriendListDataUpdated?(friendListData)
            return
        }

        if currentPage == 0 {
            friendListData = []
        }

        friendListData += allFetchedFriends[start..<end]
        currentPage += 1
        onFriendListDataUpdated?(friendListData)
    }

    private func mergeFriendList(_ list: [FriendListDetail]) -> [FriendListDetail] {
        var unique: [String: FriendListDetail] = [:]

        for friend in list {
            if let existing = unique[friend.fid] {
                if friend.updateDate > existing.updateDate {
                    unique[friend.fid] = friend
                }
            } else {
                unique[friend.fid] = friend
            }
        }

        return unique.values.sorted {
            $0.isTop == $1.isTop ? $0.updateDate > $1.updateDate : $0.isTop == "1"
        }
    }

    var hasMoreData: Bool {
        return currentPage * pageSize < allFetchedFriends.count
    }
}
