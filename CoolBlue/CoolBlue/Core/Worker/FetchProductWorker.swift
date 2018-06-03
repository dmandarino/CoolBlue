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
        let productList = parseProdcutList(json: response["products"])
        didFetchResult(productList: productList)
    }
    
    private func parseProdcutList(json: JSON) -> [Product] {
        var productList: [Product] = []
        for (_, value) in json {
            guard var product = parseJsonToProduct(json: value) else {
                continue
            }
            if let productImage = value["productImage"].string {
                product.images = [productImage]
            }
            productList.append(product)
        }
        return productList
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
        guard let product = parseProduct(json: response["product"]) else {
            didFetchResult(productList: [])
            return
        }
        didFetchResult(productList: [product])
    }
    
    private func parseProduct(json: JSON) -> Product? {
        var productImages: [String] = []
        guard var product = parseJsonToProduct(json: json) else {
            return nil
        }
        let productImagesJson = json["productImages"].arrayValue
        for image in productImagesJson {
            productImages.append(image.string!)
        }
        product.images = productImages
        if let description = json["productText"].string {
            product.description = description
        }
        return product
    }
}

//MARK: - Private FetchProductWorker

private extension FetchProductWorker {
    
    private func hasNotDefaultEndpoint() -> Bool {
        return self.endpoint == ""
    }
    
    private func isProductListNotEmpty(productList: [Product]) -> Bool {
        return !productList.isEmpty
    }
    
    private func parseJsonToProduct(json: JSON) -> Product? {
        guard let productId = json["productId"].int,
            let productName = json["productName"].string,
            let salesPriceIncVat = json["salesPriceIncVat"].int,
            let reviewAverage = json["reviewInformation"]["reviewSummary"]["reviewAverage"].double,
            let reviewCount = json["reviewInformation"]["reviewSummary"]["reviewCount"].int else {
                return nil
        }
    
        return Product(
            id: productId,
            name: productName,
            salesPriceIncVat: salesPriceIncVat,
            images: [],
            description: "",
            reviewAverage: reviewAverage,
            reviewCount: reviewCount
        )
    }
    
    private func didFetchResult(productList: [Product]) {
        if !productList.isEmpty {
            self.delegate?.didFetchWithSuccess(productList: productList)
        } else {
            self.delegate?.didFetchWithFailure()
        }
    }
}
