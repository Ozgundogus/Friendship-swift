//
//  PeopleModel.swift
//  Friendship
//
//  Created by Ozgun Dogus on 5.04.2023.
//

import Foundation
struct User: Codable {
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
    
    struct Dob: Codable {
        let age: Int
        let date: String
    }
    
    let name: Name
    let picture: Picture
    let dob: Dob
}
