//
//  ListingInteractorTests.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//


import XCTest
@testable import CoolBlue

class ListingInteractorTests: XCTestCase {
    
    var sut: ListingInteractor!
    
    override func setUp() {
        super.setUp()
    }
    
    func testFetchProductList() {
        let expectation = expected(description: "Should call fetch products")
        let worker = FetchProductWorkerMock(expectation: expectation)
        sut = ListingInteractor(worker: worker)
        sut.fetchProducts()
        waitForExpectations()
    }
}

private class FetchProductWorkerMock: FetchProductWorkerProtocol {
    
    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func fetchProductList() {
        if expected.expectationDescription == "Should call fetch products" {
            expected.fulfill()
        }
    }
}

