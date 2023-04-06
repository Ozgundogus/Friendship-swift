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
    
    override func awakeFromNib() {
            super.awakeFromNib()
        self.contentView.backgroundColor = .white
            self.contentView.layer.cornerRadius = 10
            self.contentView.layer.masksToBounds = true
            
            self.personImage.contentMode = .scaleAspectFill
            self.personImage.clipsToBounds = true
        }
}
