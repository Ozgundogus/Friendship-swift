//
//  APIManager.swift
//  Friendship
//
//  Created by Ozgun Dogus on 5.04.2023.
//

import Foundation

class ApiManager {
    static let shared = ApiManager() // Singleton instance

    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
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
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDictionary = json as? [String: Any],
                   let results = jsonDictionary["results"] as? [[String: Any]] {
                    
                    for result in results {
                        if let name = result["name"] as? [String: Any],
                           let firstName = name["first"] as? String,
                           let lastName = name["last"] as? String,
                           let picture = result["picture"] as? [String: Any],
                           let imageURLString = picture["large"] as? String,
                           let age = result["dob"] as? [String: Any],
                           let ageString = age["age"] as? Int {
                            
                            print("Ad: \(firstName) \(lastName)")
                            print("Resim URL: \(imageURLString)")
                            print("Yaş: \(ageString)")
                        }
                    }
                    
                }
            } catch {
                print("JSON ayrıştırma hatası: \(error.localizedDescription)")
            }
            
        }.resume()
    }
}


