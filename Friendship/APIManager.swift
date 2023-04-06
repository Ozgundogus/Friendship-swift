//
//  ApiManager.swift
//  Friendship
//
//  Created by Ozgun Dogus on 5.04.2023.
//

import Foundation

class ApiManager {
    static let shared = ApiManager() // Singleton instance

    func fetchData(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://randomuser.me/api/?results=20") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let response = try decoder.decode(APIResponse.self, from: data)
                completion(.success(response.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let results: [User]
}

