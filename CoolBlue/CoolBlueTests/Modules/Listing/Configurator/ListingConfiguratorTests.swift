//
//  ListingConfiguratorTests.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 27/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import CoolBlue

class ListingConfiguratorTests: XCTestCase {
    
    var sut: ListingConfigurator!
    
    override func setUp() {
        super.setUp()
        sut = ListingConfigurator()
    }
    
    func testConfigure() {
        let viewController = ListingView()
        ListingConfigurator.configure(viewController: viewController)
        
        let presenter = viewController.presenter
        let interactor = presenter?.interactor
        
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter?.delegate)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor?.delegate)
        XCTAssertNotNil(presenter?.wireframe)
    }
    
}
