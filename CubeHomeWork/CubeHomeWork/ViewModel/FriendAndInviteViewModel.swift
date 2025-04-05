//
//  FriendAndInviteViewModel.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/5.
//

import Foundation

class FriendAndInviteViewModel {
    
    let categories = ["好友", "聊天"]
    
    private(set) var allFriendList: [FriendListDetail] = []
    private(set) var friendList: [FriendListDetail] = []
    var inviteList: [FriendListDetail] = []
    
    var onFriendAndInviteData: (([FriendListDetail]) -> Void)?
    var onPersonDataUpdated: (([Response]) -> Void)?
    
    private var currentPage = 0
    private let pageSize = 20
    
    private(set) var personData: [Response]?
    
    init() {
        fetchFriendAndInviteData()
        fetchPersonData()
    }
    
    func fetchFriendAndInviteData() {
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
                case .failure(let error):
                    print("Error fetchFriendAndInviteData: \(error)")
                }
            }
        }
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
    
    func refreshFriendAndInviteData() {
        currentPage = 0
        fetchFriendAndInviteData()
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
