//
//  ListingPresenter.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

//MARk: - ListingPresenter

class ListingPresenter {
    
    var interactor: ListingInteractorProtocol?
    var wireframe: ListingWireframeProtocol?
    weak var delegate: ListingPresenterOutputProtocol?
    
    init() {
    
    }
}

//MARk: - ListingPresenterProtocol

extension ListingPresenter: ListingPresenterProtocol {
    
    func updateView() {
        interactor?.fetchProducts()
    }
    
    func didSelectedProduct(productId: Int) {
        wireframe?.navigateToProductDetail(forProductId: productId)
    }
}

//MARk: - ListingInteractorOutputProtocol

extension ListingPresenter: ListingInteractorOutputProtocol {
    
    func productFetched(productList: [Product]){
        delegate?.showProducts(productList: productList)
    }
   
    func productFetchedFailed() {
        delegate?.showError()
    }
}
