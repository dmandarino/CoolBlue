//
//  ProductDetailConfiguratorTests.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import CoolBlue

class ProductDetailConfiguratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testConfigure() {
        let viewController = ProductDetailView()
        ProductDetailConfigurator.configure(viewController: viewController)
        
        let presenter = viewController.presenter
        let interactor = presenter?.interactor
        
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.delegate)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.delegate)
        XCTAssertNotNil(presenter?.wireframe)
    }
    
}
