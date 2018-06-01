//
//  ProductDetailInteractorTests.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import CoolBlue

class ProductDetailInteractorTests: XCTestCase {
    
    var sut: ProductDetailInteractor!
    
    override func setUp() {
        super.setUp()
        sut = ProductDetailInteractor()
    }
    
    func testFetchProductList() {
        let expectation = expected(description: "Should call fetch product by Id")
        let worker = FetchProductWorkerMock(expectation: expectation)
        sut = ProductDetailInteractor(worker: worker)
        sut.fetchProduct(byProductId: 1)
        waitForExpectations()
    }
    
    func testCallProductFetched() {
        let expectation = expected(description: "Should call product fetched")
        let delegate = DelegateMock(expectation: expectation)
        let product = Product(productId: 1, productName: "Name", salesPriceIncVat: 123, productImage: "")
        sut.delegate = delegate
        sut.didFetchWithSuccess(productList: [product])
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
    
    func fetchProduct(byId id: Int) {
        if expected.expectationDescription == "Should call fetch product by Id" {
            expected.fulfill()
        }
    }
}

private class DelegateMock: ProductDetailInteractorOutputProtocol {
    
    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func productFetched(product: Product) {
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

