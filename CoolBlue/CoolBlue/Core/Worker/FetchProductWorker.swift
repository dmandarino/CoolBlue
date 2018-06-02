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
    private var productList: [Product] = []
    weak private var delegate: FetchProductWorkerOutputProtocol?
    
    init(delegate:FetchProductWorkerOutputProtocol) {
        self.delegate = delegate
    }
    
    convenience init(delegate:FetchProductWorkerOutputProtocol, endpoint: String) {
        self.init(delegate: delegate)
        self.endpoint = endpoint
    }
}

//MARK: - FetchProductListWorkerProtocol

extension FetchProductWorker: FetchProductListWorkerProtocol {
    
    func fetchProductList() {
        let requestUrl = getFetchProductListRequestUrl()
        ApiClient.sharedInstance.fetch(endpoint: requestUrl, completion: {
            [weak self] response in
                guard response != nil else {
                    self?.delegate?.didFetchWithFailure()
                    return
                }
                let json = JSON(response!)
                self?.handleResponseFetchProductList(response: json)
        })
    }
    
    private func getFetchProductListRequestUrl() -> String {
        self.pageNumber += 1
        if hasNotDefaultEndpoint() {
            self.endpoint = "/search?query=apple"
        }
        return endpoint+"&page=\(pageNumber)"
    }
    
    private func handleResponseFetchProductList(response: JSON) {
        appendProdcutList(json: response["products"])
        didFetchResult()
    }
    
    private func appendProdcutList(json: JSON) {
        for (_, value) in json {
            guard var product = parseJsonToProduct(json: value) else {
                continue
            }
            if let productImage = value["productImage"].string {
                product.images = [productImage]
            }
            productList.append(product)
        }
    }
}

//MARK: - FetchProductWorkerProtocol

extension FetchProductWorker: FetchProductWorkerProtocol {
    
    func fetchProduct(byId id: Int) {
        let requestUrl = getFetchProductRequestUrl(id: id)
        ApiClient.sharedInstance.fetch(endpoint: requestUrl, completion: {
            [weak self] response in
                guard response != nil else {
                    self?.delegate?.didFetchWithFailure()
                    return
                }
                let json = JSON(response!)
                self?.handleResponseFetchById(response: json)
        })
    }
    
    private func getFetchProductRequestUrl(id: Int) -> String {
        if hasNotDefaultEndpoint() {
            self.endpoint = "/product/"
        }
        return endpoint+"\(id)"
    }
    
    private func handleResponseFetchById(response: JSON) {
        appendProdcut(json: response["product"])
        didFetchResult()
    }
    
    private func appendProdcut(json: JSON) {
        var productImages: [String] = []
        guard var product = parseJsonToProduct(json: json) else {
            return
        }
        let productImagesJson = json["productImages"].arrayValue
        for image in productImagesJson {
            productImages.append(image.string!)
        }
        product.images = productImages
        if let description = json["productText"].string {
            product.description = description
        }
        productList.append(product)
    }
}

//MARK: - Private FetchProductWorker

private extension FetchProductWorker {
    
    private func hasNotDefaultEndpoint() -> Bool {
        return self.endpoint == ""
    }
    
    private func isProductListNotEmpty() -> Bool {
        return !self.productList.isEmpty
    }
    
    private func parseJsonToProduct(json: JSON) -> Product? {
        guard let productId = json["productId"].int,
            let productName = json["productName"].string,
            let salesPriceIncVat = json["salesPriceIncVat"].int else {
                return nil
        }
        
        return Product(
            id: productId,
            name: productName,
            salesPriceIncVat: salesPriceIncVat,
            images: [],
            description: ""
        )
    }
    
    private func didFetchResult() {
        if self.isProductListNotEmpty() {
            self.delegate?.didFetchWithSuccess(productList: self.productList)
        } else {
            self.delegate?.didFetchWithFailure()
        }
    }
}
