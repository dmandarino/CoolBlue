//
//  Product.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

struct Product {
    var id: Int
    var name: String
    var salesPriceIncVat: Int
    var images: [String]
    var description: String
}

struct Review {
    var reviewAverage: Float?
    var reviewCount: Int?
}
