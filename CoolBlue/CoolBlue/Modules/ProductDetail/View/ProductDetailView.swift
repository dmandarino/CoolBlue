//
//  ProductDetailView.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 31/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailView: UIViewController {
 
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    
    convenience init() {
        self.init(nibName: "ProductDetailView", bundle: nil)
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    private func setupView() {
        productName.showAnimatedGradientSkeleton()
        productPrice.showAnimatedGradientSkeleton()
        productDescription.showAnimatedGradientSkeleton()
    }
}
