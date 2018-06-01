//
//  ProductDetailPresenter.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

//MARK: - ProductDetailPresenter

class ProductDetailPresenter {
    
    var interactor: ProductDetailInteractorProtocol?
    var delegate: ProductDetailPresenterOutputProtocol?
    var wireframe: ProductDetailWireframeProtocol?
    
    init() {
        
    }
}

//MARK: - ProductDetailPresenterProtocol

extension ProductDetailPresenter: ProductDetailPresenterProtocol {

    func updateView(byProductId productId: Int) {
        interactor?.fetchProduct(byProductId: productId)
    }
}

//MARK: - ProductDetailInteractorOutputProtocol

extension ProductDetailPresenter: ProductDetailInteractorOutputProtocol {
    
    func productFetched(product: Product) {
        delegate?.showProduct(product: product)
    }
    
    func productFetchedFailed() {
        delegate?.showError()
    }
}
