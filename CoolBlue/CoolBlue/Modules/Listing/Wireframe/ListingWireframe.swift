//
//  ListingWireframe.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

class ListingWireframe: ListingWireframeProtocol {
    
    var navigationController: UINavigationController?
    
    func navigateToProductDetail(forProductId productId: Int) {
        let productDetailVC = ProductDetailView(productId: productId)
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
