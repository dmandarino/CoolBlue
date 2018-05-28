//
//  FetchProductListWorkerTests.swift
//  CoolBlue
//
//  Created by Douglas Mandarino on 28/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import CoolBlue

class FetchProductListWorkerTests: XCTestCase {

    var sut: FetchProductListWorker!
    
    override func setUp() {
        super.setUp()
    }
    
    func testFetchProductListWithSuccess() {
        let expectation = expected(description: "Should call delegate with Success")
        let delegate = DelegateMock(expectation: expectation)
        sut = FetchProductListWorker(delegate: delegate)
        sut.fetchProductList()
        waitForExpectations()
    }
    
    func testFetchProductListWithFailure() {
        let expectation = expected(description: "Should call delegate with Failure")
        let delegate = DelegateMock(expectation: expectation)
        sut = FetchProductListWorker(delegate: delegate, endpoint: "/")
        sut.fetchProductList()
        waitForExpectations()
    }
}

private class DelegateMock: FetchProductListWorkerOutputProtocol {
    
    var expected: XCTestExpectation
    
    init(expectation: XCTestExpectation) {
        expected = expectation
    }
    
    func didFetchWithSuccess(productList: [Product]) {
        if productList.isEmpty {
            XCTFail()
        }
        if expected.expectationDescription == "Should call delegate with Success" {
            expected.fulfill()
        }
    }
    
    func didFetchWithFailure() {
        if expected.expectationDescription == "Should call delegate with Failure" {
            expected.fulfill()
        }
    }
}
