//
//  ListingViewTests.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//


import XCTest
@testable import CoolBlue

class ListingViewTests: XCTestCase {
    
    var sut: ListingView!
    
    override func setUp() {
        super.setUp()
        sut = ListingView()
    }
    
    func testFetchValuesToBePresented() {
        let expectation = expected(description: "Should call fetchValuesToBePresented")
        let presenter = ListingPresenterMock(expectation: expectation)
        sut.presenter = presenter
        sut.updateView()
        waitForExpectations()
    }
    
    func testNotifyDidSelectedProduct() {
        let expectation = expected(description: "Should call notifyDidSelectedProduct")
        let presenter = ListingPresenterMock(expectation: expectation)
        sut.presenter = presenter
        sut.presenter?.didSelectedProduct(productId: 1)
        waitForExpectations()
    }
}

private class ListingPresenterMock: ListingPresenterProtocol {
    
    var interactor: ListingInteractorProtocol?
    var delegate: ListingPresenterOutputProtocol?
    var wireframe: ListingWireframeProtocol?
    
    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func updateView() {
        if expected.expectationDescription == "Should call fetchValuesToBePresented" {
            expected.fulfill()
        }
    }
    
    func didSelectedProduct(productId: Int) {
        if expected.expectationDescription == "Should call notifyDidSelectedProduct" {
            expected.fulfill()
        }
    }
}

