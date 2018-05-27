//
//  XCTestCaseExtensions.swift
//  CoolBlueTests
//
//  Created by Douglas Mandarino on 27/05/18.
//  Copyright © 2018 Douglas Mandarino. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func waitForExpectations() {
        return waitForExpectations(timeout: 2, handler: nil)
    }
    
    func expected(description: String) -> XCTestExpectation {
        return self.expectation(description: description)
    }
}
