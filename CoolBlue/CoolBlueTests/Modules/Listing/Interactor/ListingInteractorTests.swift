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
                sut = ListingInteractor()
    }
    
    func testFetchProductList() {
        let expectation = expected(description: "Should call fetch products")
        let worker = FetchProductWorkerMock(expectation: expectation)
        sut = ListingInteractor(worker: worker)
        sut.fetchProducts()
        waitForExpectations()
    }
    
    func testCallProductFetched() {
        let expectation = expected(description: "Should call product fetched")
        let delegate = DelegateMock(expectation: expectation)
        sut.delegate = delegate
        sut.didFetchWithSuccess(productList: [])
        waitForExpectations()
    }
    
    func testCallProductFetchedFailed() {
        let expectation = expected(description: "Should call product fetched failed")
        let delegate = DelegateMock(expectation: expectation)
        sut.delegate = delegate
        sut.didFetchWithFailure()
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

private class DelegateMock: ListingInteractorOutputProtocol {

    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func productFetched(productList: [Product]) {
        if expected.expectationDescription == "Should call product fetched" {
            expected.fulfill()
        }
    }
    
    func productFetchedFailed() {
        if expected.expectationDescription == "Should call product fetched failed" {
            expected.fulfill()
        }
    }
}

