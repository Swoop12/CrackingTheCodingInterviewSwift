//
//  StacksAndQueuesTests.swift
//  AlgoTests
//
//  Created by Trevor Adcock on 5/16/22.
//

import XCTest
@testable import Algo

class StacksTests: XCTestCase {

    func testMinStackOne() {
        var stack: StackWithMin = [10, 8, 9, 6, 7, 4, 5, 2, 3, 1, 10, 11]
        XCTAssertEqual(stack.min, 1)
        
        stack.push(-20)
        stack.push(100)
        XCTAssertEqual(stack.min, -20)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 1)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 2)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 8)
    }

    func testMinStackTwo() {
        var stack = StackWithMinEfficient<Int>()
        [10, 8, 9, 6, 7, 4, 5, 2, 3, 1, 10, 11].forEach { stack.push($0) }
        XCTAssertEqual(stack.min, 1)
        
        stack.push(-20)
        stack.push(100)
        XCTAssertEqual(stack.min, -20)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 1)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 2)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 8)
    }
}
