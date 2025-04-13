//
//  FriendAndInviteViewModel.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/12.
//

import Foundation
import UIKit

class FriendAndInviteViewModel {
    var selectCase: Int?
    var allFriendList: [FriendListDetail] = []
    var friendList: [FriendListDetail] = []
    var inviteList: [FriendListDetail] = []
    var onFriendAndInviteData: (([FriendListDetail]) -> Void)?
    var onPersonDataUpdated: (([Response]) -> Void)?
    var onFilterDataUpdated: (([FriendListDetail]) -> Void)?
    var currentPage = 0
    let pageSize = 20
    var personData: [Response]?
    
    init() {
        fetchPersonData()
    }
    
    func fetchPersonData() {
        let url = "https://dimanyen.github.io/man.json"
        ApiManager.shared.getApiData(url, type: PersonData.self) { [weak self] result in
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
    
    func  fetchFriendData() {
        switch selectCase {
        case 0:
            let url = "https://dimanyen.github.io/friend4.json"
            ApiManager.shared.getApiData(url, type: PersonData.self) { [weak self] result in
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
            break
        case 1:
            let friendURLs = [
                "https://dimanyen.github.io/friend1.json",
                "https://dimanyen.github.io/friend2.json"
            ]
            
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
                
                var unique: [String: FriendListDetail] = [:]
                for friend in fetchedFriends {
                    if let existing = unique[friend.fid] {
                        if friend.updateDate > existing.updateDate {
                            unique[friend.fid] = friend
                        }
                    } else {
                        unique[friend.fid] = friend
                    }
                }
                
                let merged = unique.values.sorted {
                    $0.isTop == $1.isTop ? $0.updateDate > $1.updateDate : $0.isTop == "1"
                }
                
                self.allFriendList = merged
                self.friendList = Array(merged.prefix(self.pageSize))
                self.currentPage = 1
                self.onFriendAndInviteData?(self.friendList)
            }
            
        case 2:
            
            let url = "https://dimanyen.github.io/friend3.json"
            
            ApiManager.shared.getApiData(url, type: FriendList.self) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let friendDetail):
                        let friendFiltered = friendDetail.response.filter { $0.status != 0 }
                        let sorted = friendFiltered.sorted {
                            if $0.status == 2 && $1.status != 2 {
                                return true
                            }
                            if $0.status != 2 && $1.status == 2 {
                                return false
                            }
                            return $0.isTop == "1" && $1.isTop != "1"
                        }
                        
                        self?.allFriendList = sorted
                        self?.friendList = Array(sorted.prefix(self?.pageSize ?? 20))
                        self?.currentPage = 1
                        self?.onFriendAndInviteData?(self?.friendList ?? [])
                        
                        let inviteFiltered = friendDetail.response.filter { $0.status == 0 }
                        self?.inviteList = inviteFiltered
                        self?.onFilterDataUpdated?(self?.inviteList ?? [])
                        
                    case .failure(let error):
                        print("Error fetchFriendAndInviteData: \(error)")
                    }
                }
            }
            
            break
        default:
            print("select mode is wrong")
        }
    }
    
    func refreshFriendList() {
        currentPage = 0
        fetchFriendData()
    }
    
    func loadMoreFriendList() {
        let start = currentPage * pageSize
        let end = min(start + pageSize, allFriendList.count)
        
        guard start < end else { return }
        
        let nextPage = Array(allFriendList[start..<end])
        friendList += nextPage
        currentPage += 1
        onFriendAndInviteData?(friendList)
    }
    
    var hasMoreData: Bool {
        return currentPage * pageSize < allFriendList.count
    }
}
