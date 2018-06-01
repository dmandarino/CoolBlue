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
    private var worker:FetchProductWorkerProtocol?
    
    init() {
        self.worker = FetchProductWorker(delegate: self)
    }
    
    convenience init(worker: FetchProductWorkerProtocol) {
        self.init()
        self.worker = worker
    }
}

//MARK: - ProductDetailInteractorProtocol

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    func fetchProduct(byProductId productId: Int) {
        worker?.fetchProduct(byId: productId)
    }
}

//MARK: - FetchProductListWorkerOutputProtocol

extension ProductDetailInteractor: FetchProductWorkerOutputProtocol {
    
    func didFetchWithSuccess(productList: [Product]) {
        guard let product = productList.first else {
            didFetchWithFailure()
            return
        }
        delegate?.productFetched(product: product)
    }
    
    func didFetchWithFailure(){
        delegate?.productFetchedFailed()
    }
}

