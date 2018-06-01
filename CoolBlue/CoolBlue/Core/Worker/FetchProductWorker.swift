//
//  FetchProductWorker.swift
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

protocol FetchProductWorkerProtocol {
    func fetchProduct(byId id: Int)
}

protocol FetchProductWorkerOutputProtocol: class {
    func didFetchWithSuccess(productList: [Product])
    func didFetchWithFailure()
}

//MARK: - FetchProductWorker

class FetchProductWorker {
    
    private var pageNumber = 0
    private var endpoint: String = ""
    private var productList: [Product]?
    weak private var delegate: FetchProductWorkerOutputProtocol?
    
    init(delegate:FetchProductWorkerOutputProtocol) {
        self.delegate = delegate
    }
    
    convenience init(delegate:FetchProductWorkerOutputProtocol, endpoint: String) {
        self.init(delegate: delegate)
        self.endpoint = endpoint
    }
    
    private func parseProduct(json: JSON) -> [Product] {
        var productList: [Product] = []
        for (_, value) in json {
            guard let productId = value["productId"].int,
            let productName = value["productName"].string,
            let salesPriceIncVat = value["salesPriceIncVat"].int,
            let productImage = value["productImage"].string else {
                return productList
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
    
    private func hasNotDefaultEndpoint() -> Bool {
        return self.endpoint == ""
    }
}

//MARK: - FetchProductListWorkerProtocol

extension FetchProductWorker: FetchProductListWorkerProtocol {
    
    func fetchProductList() {
        self.pageNumber += 1
        if hasNotDefaultEndpoint() {
            self.endpoint = "/search?query=apple"
        }
        let requestUrl = endpoint+"&page=\(pageNumber)"
        ApiClient.sharedInstance.fetch(endpoint: requestUrl,
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
            } else {
                self.delegate?.didFetchWithFailure()
            }
        })
    }
}

//MARK: - FetchProductWorkerProtocol

extension FetchProductWorker: FetchProductWorkerProtocol {
    
    func fetchProduct(byId id: Int) {
        
    }
}
