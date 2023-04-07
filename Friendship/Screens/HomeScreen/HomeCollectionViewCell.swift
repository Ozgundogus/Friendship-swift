//
//  HomeCollectionViewCell.swift
//  Friendship
//
//  Created by Ozgun Dogus on 5.04.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personAge: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    
       func configure(with user: User) {
           
//           if let imageUrl = user.imageURL {
//                 guard let image = UIImage.load(from: imageUrl) else {
//                     self.personImage.image = UIImage(named: "defaultImage")
//                     return
//                 }
//                 self.personImage.image = image
//             } else {
//                 self.personImage.image = UIImage(named: "defaultImage")
//             }
           if let imageUrl = user.imageURL, let imageData = try? Data(contentsOf: imageUrl), let image = UIImage(data: imageData) {
               self.personImage.image = image
           } else {
               self.personImage.image = UIImage(named: "defaultImage")
           }


             self.personName.text = user.fullname

             if let dob = user.dob {
                 self.personAge.text = "\(dob.age)"
             } else {
                 self.personAge.text = "Age not available"
             }
           
//           if let imageUrl = user.imageURL {
//              if let image = UIImage.load(from: imageUrl) {
//                 self.personImage.image = image
//              } else {
//                 self.personImage.image = UIImage(named: "defaultImage")
//              }
//           } else {
//              self.personImage.image = UIImage(named: "defaultImage")
//           }
//
//           self.personName.text = user.fullname
//
//           // Add nil check for dob
//           guard let dob = user.dob else {
//               self.personAge.text = "Age not available"
//               return
//           }
//           self.personAge.text = "\(dob.age)"
       }
    
    override func awakeFromNib() {
            super.awakeFromNib()
        print("awakeFromNib() called")
        self.contentView.backgroundColor = .white
            self.contentView.layer.cornerRadius = 10
            self.contentView.layer.masksToBounds = true
     
        self.personImage.contentMode = .scaleToFill
            self.personImage.clipsToBounds = true
        self.personImage.clipsToBounds = true
        self.personImage.widthAnchor.constraint(equalToConstant: 350).isActive = true
        self.personImage.heightAnchor.constraint(equalToConstant: 215).isActive = true
        }
}
