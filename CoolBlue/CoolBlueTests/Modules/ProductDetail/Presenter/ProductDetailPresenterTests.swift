//
//  ProductDetailPresenterTests.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 01/06/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//


import XCTest
@testable import CoolBlue

class ProductDetailPresenterTests: XCTestCase {
    
    var sut: ProductDetailPresenter!
    
    override func setUp() {
        super.setUp()
        sut = ProductDetailPresenter()
    }
    
    func testFetchValuesToBePresented() {
        let expectation = expected(description: "Should call fetchProductById")
        let interactor = ProductDetailInteractorMock(expectation: expectation)
        sut.interactor = interactor
        sut.updateView(byProductId: 1)
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
        let expectation = expected(description: "Should call showProduct")
        let delegate = DelegateMock(expectation: expectation)
        let product = Product(productId: 1, productName: "Name", salesPriceIncVat: 123, productImage: "image")
        sut.delegate = delegate
        sut.productFetched(product: product)
        waitForExpectations()
    }
}

private class ProductDetailInteractorMock: ProductDetailInteractorProtocol {
    
    var delegate: ProductDetailInteractorOutputProtocol?
    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func fetchProduct(byProductId productId: Int) {
        if expected.expectationDescription == "Should call fetchProductById" {
            expected.fulfill()
        }
    }
}

private class DelegateMock: ProductDetailPresenterOutputProtocol {
    
    private var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func showError() {
        if expected.expectationDescription == "Should call showError" {
            expected.fulfill()
        }
    }
    
    func showProduct(product: Product) {
        if expected.expectationDescription == "Should call showProduct" {
            expected.fulfill()
        }
    }
}

