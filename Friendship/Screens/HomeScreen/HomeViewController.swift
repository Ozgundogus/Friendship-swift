//
//  HomeViewController.swift
//  Friendship
//
//  Created by Ozgun Dogus on 5.04.2023.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var users: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        
        
        ApiManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let users):
                print(users)
//                print([User].Element.Name)
//                print([User].Element.Picture)
//                print([User].Element.Dob)
                self?.users = users
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
            }
        }
        
        
        
        
        
        //        ApiManager.shared.fetchData { [weak self] result in
        //            switch result {
        //            case .success(let data):
        //                do {
        //                    let json = try JSONSerialization.jsonObject(with: data, options: [])
        //                    if let jsonDictionary = json as? [String: Any],
        //                       let results = jsonDictionary["results"] as? [[String: Any]] {
        //
        //                        for result in results {
        //                            if let picture = result["picture"] as? [String: Any],
        //                               let imageURLString = picture["large"] as? String,
        //                               let imageURL = URL(string: imageURLString),
        //                               let imageData = try? Data(contentsOf: imageURL),
        //                               let image = UIImage(data: imageData),
        //                            let name = result["name"] as? [String: Any],
        //                            let firstName = name["first"] as? String,
        //                            let age = result["dob"] as? [String: Any],
        //                            let ageString = age["age"] as? String,
        //                            let ageInt = Int(ageString)
        //                            {
        //
        //                                self?.images.append(image)
        //                                self?.names.append(firstName)
        //                                self?.ages.append(ageInt)
        //                            }
        //                        }
        //
        //                        DispatchQueue.main.async {
        //                            self?.collectionView.reloadData()
        //                        }
        //
        //                    }
        //                } catch {
        //                    print("JSON ayrıştırma hatası: \(error.localizedDescription)")
        //                }
        //
        //            case .failure(let error):
        //                print("API Hatası: \(error.localizedDescription)")
        //            }
        //        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let user = users[indexPath.row]
        
        cell.personName.text = "\(user.name?.first ?? "")  \(user.name?.last ?? "")"
        cell.personAge.text = "\(String(describing: user.dob?.age))"
        
        // Resim indirme işlemleri
        if let url = URL(string: user.picture?.large ?? "") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    cell.personImage.image = UIImage(data: data)
                }
            }.resume()
        } else {
            print("URL nil dönüyor")
            return cell
            
            
            
            
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let width = (collectionView.frame.width - 20) / 2
                return CGSize(width: width, height: width)
                
                //        let imageView = UIImageView(frame: cell.contentView.bounds)
                //Burada, indexPath.row dizinin boyutundan küçük olduğu sürece ve images[indexPath.row] değeri nil değilse, //imageView'a image atanır. Aksi takdirde, hata oluşmaz.
                //        if indexPath.row < images.count {
                //                let image = images[indexPath.row]
                //                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.contentView.bounds.width, height: cell.contentView.bounds.height - 40))
                //                imageView.image = image
                //                imageView.contentMode = .scaleAspectFill
                //                imageView.clipsToBounds = true
                //                cell.contentView.addSubview(imageView)
                //
                //                let nameLabel = UILabel(frame: CGRect(x: 0, y: cell.contentView.bounds.height - 40, width: cell.contentView.bounds.width, height: 20))
                //                nameLabel.text = names[indexPath.row]
                //                nameLabel.textAlignment = .center
                //                cell.contentView.addSubview(nameLabel)
                //
                //                let ageLabel = UILabel(frame: CGRect(x: 0, y: cell.contentView.bounds.height - 20, width: cell.contentView.bounds.width, height: 20))
                //                ageLabel.text = "\(ages[indexPath.row]) yaşında"
                //                ageLabel.textAlignment = .center
                //                cell.contentView.addSubview(ageLabel)
                //            }
                //
                //               return cell
                
                
            }
            
            
            
            
            
            
        }
        return cell
        
    }
}
