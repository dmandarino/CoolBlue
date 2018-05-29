//
//  ListingPresenterTests.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//


import XCTest
@testable import CoolBlue

class ListingPresenterTests: XCTestCase {
    
    var sut: ListingPresenter!
    
    override func setUp() {
        super.setUp()
        sut = ListingPresenter()
    }
    
    func testFetchValuesToBePresented() {
        let expectation = expected(description: "Should call fetchProducts")
        let interactor = ListingInteractorMock(expectation: expectation)
        sut.interactor = interactor
        sut.updateView()
        waitForExpectations()
    }
    
    func testShowError() {
        let expectation = expected(description: "Should call showError")
        let delegate = DelegateMock(expectation: expectation)
        sut.delegate = delegate
        sut.productFetchedFailed()
        waitForExpectations()
    }
    
    func testShowProducts() {
        let expectation = expected(description: "Should call showProducts")
        let delegate = DelegateMock(expectation: expectation)
        sut.delegate = delegate
        sut.productFetched(productList: [])
        waitForExpectations()
    }
}

private class ListingInteractorMock: ListingInteractorProtocol {

    var delegate: ListingInteractorOutputProtocol?
    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func fetchProducts() {
        if expected.expectationDescription == "Should call fetchProducts" {
            expected.fulfill()
        }
    }
}

private class DelegateMock: ListingPresenterOutputProtocol {

    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func showError() {
        if expected.expectationDescription == "Should call showError" {
            expected.fulfill()
        }
    }
    
    func showProducts(productList: [Product]) {
        if expected.expectationDescription == "Should call showProducts" {
            expected.fulfill()
        }
    }
}

