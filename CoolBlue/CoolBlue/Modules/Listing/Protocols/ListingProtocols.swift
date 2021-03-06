//
//  ListingProtocols.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation
import UIKit

protocol ListingViewProtocol {
    var presenter: ListingPresenterProtocol? {get}
    
    func updateView()
}

protocol ListingPresenterProtocol {
    var interactor: ListingInteractorProtocol? {get}
    var delegate: ListingPresenterOutputProtocol? {get}
    var wireframe: ListingWireframeProtocol? {get}
    
    func updateView()
    func didSelectedProduct(productId: Int)
}

protocol ListingPresenterOutputProtocol: class {
    func showError()
    func showProducts(productList: [Product])
}

protocol ListingInteractorOutputProtocol: class {
    func productFetched(productList: [Product])
    func productFetchedFailed()
}

protocol ListingInteractorProtocol {
    var delegate: ListingInteractorOutputProtocol? {get}
    
    func fetchProducts()
}

protocol ListingWireframeProtocol {
    var navigationController: UINavigationController? {get set}
    
    func navigateToProductDetail(forProductId productId: Int)
}
