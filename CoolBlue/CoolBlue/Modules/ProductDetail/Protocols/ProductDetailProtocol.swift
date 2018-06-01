//
//  ProductDetailProtocol.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 31/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

protocol ProductDetailViewProtocol {
    var presenter: ProductDetailPresenterProtocol? {get}
    
    func updateView()
}

protocol ProductDetailPresenterProtocol {
    var interactor: ProductDetailInteractorProtocol? {get}
    var delegate: ProductDetailPresenterOutputProtocol? {get}
    var wireframe: ProductDetailWireframeProtocol? {get}
    
    func updateView()
}

protocol ProductDetailPresenterOutputProtocol: class {
    func showError()
    func showProduct(product: Product)
}

protocol ProductDetailInteractorOutputProtocol: class {
    func productFetched(product: Product)
    func productFetchedFailed()
}

protocol ProductDetailInteractorProtocol {
    var delegate: ProductDetailInteractorOutputProtocol? {get}
    
    func fetchProduct()
}

protocol ProductDetailWireframeProtocol {
    
}
