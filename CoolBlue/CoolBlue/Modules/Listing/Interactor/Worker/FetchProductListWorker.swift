//
//  FetchProductListWorker.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FetchProductListWorkerProtocol {
    func fetchProductList()
}

protocol FetchProductListWorkerOutputProtocol: class {
    func didFetchWithSuccess(productList: [Product])
    func didFetchWithFailure()
}

class FetchProductListWorker: FetchProductListWorkerProtocol {
    
    private var pageNumber = 0
    private var productList: [Product]?
    weak private var delegate: FetchProductListWorkerOutputProtocol?
    
    init(delegate:FetchProductListWorkerOutputProtocol) {
        self.delegate = delegate
    }
    
    func fetchProductList() {
        pageNumber += 1
        ApiClient.sharedInstance.fetch(endpoint: "/search?query=apple&page=\(pageNumber)",
            completion: { response in
                if response != nil {
                    let json = JSON(response!)
                    let objects = json["products"]
                    self.productList = self.parseProduct(json: objects)
                    if self.productList != nil && !(self.productList?.isEmpty)! {
                        self.delegate?.didFetchWithSuccess(productList: self.productList!)
                    } else {
                        self.delegate?.didFetchWithFailure()
                    }
                }
        })
    }
    
    private func parseProduct(json: JSON) -> [Product] {
        var productList: [Product] = []
        for (_, value) in json {
            guard let productId = value["productId"].int,
            let productName = value["productName"].string,
            let salesPriceIncVat = value["salesPriceIncVat"].int,
            let productImage = value["productImage"].string else {
                return []
            }
            
            let product = Product(
                productId: productId,
                productName: productName,
                salesPriceIncVat: salesPriceIncVat,
                productImage: productImage
            )
            
            productList.append(product)
        }
        return productList
    }
}
