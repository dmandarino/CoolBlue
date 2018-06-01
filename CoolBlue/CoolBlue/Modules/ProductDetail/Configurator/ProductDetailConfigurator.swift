//
//  ProductDetailConfigurator.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

//MARK: - ProductDetailConfigurator

class ProductDetailConfigurator {
    
    private static let interactor = ProductDetailInteractor()
    private static let presenter = ProductDetailPresenter()
    private static let wireframe = ProductDetailWireframe()
    
    // MARK: Configuration
    
    static func configure(viewController: ProductDetailView) {
        wireframe.navigationController = viewController.navigationController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.delegate = presenter
        viewController.presenter = presenter
        presenter.delegate = viewController
    }
}
