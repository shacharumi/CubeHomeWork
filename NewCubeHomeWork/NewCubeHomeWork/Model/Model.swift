//
//  Model.swift
//  NewCubeHomeWork
//
//  Created by shachar on 2025/4/12.
//

import Foundation

struct PersonData: Codable {
    let response: [Response]
}

// MARK: - Response
struct Response: Codable {
    let name, kokoid: String
}


// MARK: - FriendList
struct FriendList: Codable {
    let response: [FriendListDetail]
}

// MARK: - Response
struct FriendListDetail: Codable {
    let name: String
    let status: Int
    let isTop, fid, updateDate: String
}
