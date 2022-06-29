//
//  People.swift
//  FilmsProject
//
//  Created by info 0033 on 28/06/22.
//

import Foundation


// MARK: - PeopleResult
struct PeopleResult: Codable {
    var info: Info?
    var results: [People]?
}

// MARK: - Info
struct Info: Codable {
    var count, pages: Int?
    var next: String?
}

// MARK: - Result
struct People: Codable {
    var id: Int?
    var name: String
    var status: Status?
    var species: Species?
    var type: String?
    var gender: Gender?
    var origin, location: Location?
    var image: String
    var episode: [String]?
    var url: String
    var created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Codable {
    var name: String?
    var url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
