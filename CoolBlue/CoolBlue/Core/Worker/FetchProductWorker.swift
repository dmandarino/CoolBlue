//
//  FetchProductWorker.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import SwiftyJSON


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
    
    private func hasNotDefaultEndpoint() -> Bool {
        return self.endpoint == ""
    }
    
    private func isProductListNotEmpty() -> Bool {
        return self.productList != nil && !(self.productList?.isEmpty)!
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
           completion: { [weak self] response in
            if response != nil {
                let json = JSON(response!)
                let objects = json["products"]
                self?.productList = self?.parseProductList(json: objects)
                if (self?.isProductListNotEmpty())! {
                    self?.delegate?.didFetchWithSuccess(productList: (self?.productList!)!)
                } else {
                    self?.delegate?.didFetchWithFailure()
                }
            } else {
                self?.delegate?.didFetchWithFailure()
            }
        })
    }
    
    private func parseProductList(json: JSON) -> [Product] {
        var productList: [Product] = []
        for (_, value) in json {
            guard let productId = value["productId"].int,
                let productName = value["productName"].string,
                let salesPriceIncVat = value["salesPriceIncVat"].int,
                let productImage = value["productImage"].string else {
                    return productList
            }
            
            let product = Product(
                id: productId,
                name: productName,
                salesPriceIncVat: salesPriceIncVat,
                images: [productImage],
                description: ""
            )
            
            productList.append(product)
        }
        return productList
    }
}

//MARK: - FetchProductWorkerProtocol

extension FetchProductWorker: FetchProductWorkerProtocol {
    
    func fetchProduct(byId id: Int) {
        if hasNotDefaultEndpoint() {
            self.endpoint = "/product/"
        }
        let requestUrl = endpoint+"\(id)"
        ApiClient.sharedInstance.fetch(endpoint: requestUrl,
           completion: { [weak self] response in
            if response != nil {
                let json = JSON(response!)
                let object = json["product"]
                self?.productList = self?.parseProduct(json: object)
                if (self?.isProductListNotEmpty())! {
                    self?.delegate?.didFetchWithSuccess(productList: (self?.productList!)!)
                } else {
                    self?.delegate?.didFetchWithFailure()
                }
            } else {
                self?.delegate?.didFetchWithFailure()
            }
        })
    }
    
    private func parseProduct(json: JSON) -> [Product] {
        var productList: [Product] = []
        var productImages: [String] = []
        guard let productId = json["productId"].int,
        let productName = json["productName"].string,
        let salesPriceIncVat = json["salesPriceIncVat"].int,
        let description = json["productText"].string else {
            return productList
        }
        
        let productImagesJson = json["productImages"].arrayValue

        for image in productImagesJson {
            productImages.append(image.string!)
        }
        
        let product = Product(
            id: productId,
            name: productName,
            salesPriceIncVat: salesPriceIncVat,
            images: productImages,
            description: description
        )
            
        productList.append(product)
        return productList
    }
}
