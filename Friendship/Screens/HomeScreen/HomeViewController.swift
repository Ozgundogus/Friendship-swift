//
//  HomeViewController.swift
//  Friendship
//
//  Created by Ozgun Dogus on 5.04.2023.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
  
    var images = [UIImage]()
   
    
 
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
   
        
        ApiManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let jsonDictionary = json as? [String: Any],
                       let results = jsonDictionary["results"] as? [[String: Any]] {
                        
                        for result in results {
                            if let picture = result["picture"] as? [String: Any],
                               let imageURLString = picture["large"] as? String,
                               let imageURL = URL(string: imageURLString),
                               let imageData = try? Data(contentsOf: imageURL),
                               let image = UIImage(data: imageData) {
                                
                                self?.images.append(image)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self?.collectionView.reloadData()
                        }
                        
                    }
                } catch {
                    print("JSON ayrıştırma hatası: \(error.localizedDescription)")
                }
                
            case .failure(let error):
                print("API Hatası: \(error.localizedDescription)")
            }
        }

    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let imageView = UIImageView(frame: cell.contentView.bounds)
        if indexPath.row < images.count {
            let image = images[indexPath.row]
            imageView.image = image
        }

        cell.contentView.addSubview(imageView)

               return cell
        
    }
  

}
