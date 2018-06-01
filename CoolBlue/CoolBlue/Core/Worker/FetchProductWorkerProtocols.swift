//
//  FetchProductWorkerProtocols.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

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
