//
//  Model.swift
//  CubeHomeWork
//
//  Created by shachar on 2025/4/3.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let personData = try? JSONDecoder().decode(PersonData.self, from: jsonData)

import Foundation

// MARK: - PersonData
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
