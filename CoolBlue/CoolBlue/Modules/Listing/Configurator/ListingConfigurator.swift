//
//  ListingConfigurator.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 26/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import Foundation

//MARK: - ListingConfigurator

class ListingConfigurator {
    
    private static let interactor = ListingInteractor()
    private static let presenter = ListingPresenter()
    private static let wireframe = ListingWireframe()
    
    // MARK: Configuration
    
    static func configure(viewController: ListingView) {
        wireframe.navigationController = viewController.navigationController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.delegate = presenter
        viewController.presenter = presenter
        presenter.delegate = viewController
    }
}
