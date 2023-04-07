//
//  PeopleModel.swift
//  Friendship
//
//  Created by Ozgun Dogus on 5.04.2023.
//

import Foundation
 class User: Codable {
    var name: Name?
   
    let dob: Dob?
    let picture: Picture?
    
    // Add URL property
    var imageURL: URL? = nil
    var fullname: String {
        return "\(name?.first ) \(name?.last )"
        
    }
    
    struct Dob: Codable {
        let date: String?
        let age: Int?
    }
    
    struct Name: Codable {
        let title: String?
        let first: String?
        let last: String?
    }
    
    struct Picture: Codable {
        let large: String?
        let medium: String?
        let thumbnail: String?
    }
    
    // Add initializer to update URL property
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
               name = try container.decode(Name.self, forKey: .name)
               dob = try container.decode(Dob.self, forKey: .dob)
               picture = try container.decode(Picture.self, forKey: .picture)
               
               
        if let urlString = picture?.large, let url = URL(string: urlString) {
                  imageURL = url
              }
    }
    
}

