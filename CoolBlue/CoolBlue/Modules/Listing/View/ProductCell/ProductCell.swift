//
//  ProductCell.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 30/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
