//
//  ProductDetailViewTests.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import CoolBlue

class ProductDetailViewTests: XCTestCase {
    
    var sut: ProductDetailView!
    
    override func setUp() {
        super.setUp()
        sut = ProductDetailView(productId: 1)
    }
    
    func testUpdateViewToBePresented() {
        let expectation = expected(description: "Should call updateView in presenter")
        let presenter = ProductDetailPresenterMock(expectation: expectation)
        sut.presenter = presenter
        sut.updateView()
        waitForExpectations()
    }
}

private class ProductDetailPresenterMock: ProductDetailPresenterProtocol {
    
    var interactor: ProductDetailInteractorProtocol?
    var delegate: ProductDetailPresenterOutputProtocol?
    var wireframe: ProductDetailWireframeProtocol?
    
    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func updateView(byProductId productId: Int) {
        if expected.expectationDescription == "Should call updateView in presenter" {
            expected.fulfill()
        }
    }
}
