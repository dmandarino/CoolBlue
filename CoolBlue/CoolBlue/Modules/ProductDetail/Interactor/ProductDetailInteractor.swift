//
//  ProductDetailInteractor.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation


//MARK: - ProductDetailInteractor

class ProductDetailInteractor {
    
    var delegate: ProductDetailInteractorOutputProtocol?
    
}

//MARK: - ProductDetailInteractorProtocol

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    func fetchProduct() {
        
    }
}
