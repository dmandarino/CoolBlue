//
//  ListingProtocols.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

protocol ListingViewProtocol {
    var presenter: ListingPresenterProtocol? {get}
    
    func askForProducts()
}

protocol ListingPresenterProtocol {
    var interactor: ListingInteractorProtocol? {get}
    var delegate: ListingPresenterOutputProtocol? {get}
    var wireframe: ListingWireframeProtocol? {get}
    
    func fetchValuesToBePresented()
}

protocol ListingPresenterOutputProtocol: class {
    
}

protocol ListingInteractorOutputProtocol: class {

}

protocol ListingInteractorProtocol {
    var delegate: ListingInteractorOutputProtocol? {get}
    
    func fetchProducts()
}

protocol ListingWireframeProtocol {
    
}
