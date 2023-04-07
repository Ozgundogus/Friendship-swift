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
        guard let url = URL(string: "https://randomuser.me/api/?results=20&inc=name,dob,picture") else {
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
                decoder.keyDecodingStrategy = .useDefaultKeys

                let response = try decoder.decode(APIResponse.self, from: data)
                let users = response.results.compactMap { result -> User? in
                    if let data = try? JSONEncoder().encode(result) {
                        let decoder = JSONDecoder()
                        if let user = try? decoder.decode(User.self, from: data) {
                            return user
                        }
                    }
                    return nil
                }

                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let results: [User]
}

