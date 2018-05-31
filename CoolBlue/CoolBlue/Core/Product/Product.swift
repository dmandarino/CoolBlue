//
//  Product.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

struct Product {
    var productId: Int
    var productName: String
//    var reviewInformation: Review
//    var usp: [String]
    var salesPriceIncVat: Int
    var productImage: String
}

struct Review {
    var reviewAverage: Float?
    var reviewCount: Int?
}
