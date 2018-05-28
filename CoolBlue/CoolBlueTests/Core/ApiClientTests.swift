//
//  ApiClientTests.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 27/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import XCTest
@testable import CoolBlue

class ApiClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testFetch() {
        let expectation = expected(description: "Should return when calling fetch")
        ApiClient.sharedInstance.fetch(endpoint: "", completion: { response in
            guard let value = response?["Welcome"] as? String else {
                XCTFail()
                return
            }
            XCTAssertEqual("This is the iOS assignment\'s API. Have fun!", value)
            expectation.fulfill()
        })
        waitForExpectations()
    }
    
    func testFetchFail() {
        let expectation = expected(description: "Should return when calling fetch")
        ApiClient.sharedInstance.fetch(endpoint: "/fail", completion: { response in
            if response != nil {
                XCTFail()
            }
            expectation.fulfill()
        })
        waitForExpectations()
    }
}
