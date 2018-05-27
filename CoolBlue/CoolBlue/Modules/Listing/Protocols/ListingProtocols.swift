//
//  ListingProtocols.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

protocol ListingViewProtocol {
//    var presenter: ListingPresenterProtocol? {get}
}

protocol ListingPresenterProtocol {
//    var interactor: ListingInteractorProtocol? {get set}
    var delegate: ListingPresenterOutputProtocol? {get set}
}

protocol ListingPresenterOutputProtocol: class {
    
}

protocol ListingInteractorOutputProtocol: class {
//    var delegate: ListingPresenterOutputProtocol? {get set}
}

protocol ListingInteractorProtocol {
    var delegate: ListingInteractorOutputProtocol? {get set}
}

protocol ListingWireframeProtocol {
    
}
