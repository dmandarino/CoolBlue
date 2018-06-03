//
//  ListingInteractor.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

//MARK: - ListingInteractor

class ListingInteractor {
    
    weak var delegate: ListingInteractorOutputProtocol?
    private var worker:FetchProductListWorkerProtocol?
    private var productList: [Product] = []
    
    init() {
        self.worker = FetchProductWorker(delegate: self)
    }
    
    convenience init(worker: FetchProductListWorkerProtocol) {
        self.init()
        self.worker = worker
    }
}

//MARK: - ListingInteractorOutputProtocol

extension ListingInteractor: ListingInteractorProtocol {
    
    func fetchProducts() {
        worker?.fetchProductList()
    }
}

//MARK: - FetchProductListWorkerOutputProtocol

extension ListingInteractor: FetchProductWorkerOutputProtocol {
    
    func didFetchWithSuccess(productList: [Product]) {
        self.productList.append(contentsOf: productList)
        delegate?.productFetched(productList: self.productList)
    }
    
    func didFetchWithFailure(){
        delegate?.productFetchedFailed()
    }
}

