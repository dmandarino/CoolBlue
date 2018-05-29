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
    private var worker:FetchProductWorkerProtocol?
    
    init() {
        self.worker = FetchProductWorker(delegate: self)
    }
    
    convenience init(worker: FetchProductWorkerProtocol) {
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
        delegate?.productFetched(productList: productList)
    }
    
    func didFetchWithFailure(){
        delegate?.productFetchedFailed()
    }
}

