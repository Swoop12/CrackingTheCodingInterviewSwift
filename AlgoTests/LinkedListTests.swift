//
//  AlgoTests.swift
//  AlgoTests
//
//  Created by Trevor Adcock on 5/12/22.
//

import XCTest
import Foundation
@testable import Algo

class LinkedListTests: XCTestCase {

    func testLinkedListCreation() {
        let list = LinkedList(start: 1)
        (0...10).forEach { list.append($0) }
        XCTAssertEqual(list.start?.value, 1)
        XCTAssertEqual(list.last?.value, 10)
    }

    func testLinkedListDelete() {
        let list = LinkedList(start: 1)
        list.append(2)
        list.append(3)
        list.append(4)
        let isDeleted = list.deleteFirstIndex(of: 3)
        let second = list.start?.next
        let third = second?.next
        XCTAssertTrue(isDeleted)
        XCTAssertEqual(list.start?.value, 1)
        XCTAssertEqual(second?.value, 2)
        XCTAssertEqual(third?.value, 4)
        XCTAssertNil(third?.next)
    }
    
    func testLinkedListDeleteFirst() {
        let list = LinkedList(start: 1)
        list.append(2)
        list.append(3)
        list.append(4)
        let isDeleted = list.deleteFirstIndex(of: 1)
        let second = list.start?.next
        let third = second?.next
        XCTAssertTrue(isDeleted)
        XCTAssertEqual(list.start?.value, 2)
        XCTAssertEqual(second?.value, 3)
        XCTAssertEqual(third?.value, 4)
        XCTAssertNil(third?.next)
    }
    
    func testForEach() {
        let list = LinkedList(start: 0)
        (1...5).forEach { list.append($0) }
        var array: [Int] = []
        list.forEach { value in
            array.append(value)
        }
        XCTAssertEqual(array, [0,1,2,3,4,5])
    }
    
    func testSequenceConformance() {
        let list = LinkedList(start: 0)
        (1...5).forEach { list.append($0) }
        
        var firstIterationArray = [Int]()
        for value in list {
            firstIterationArray.append(value)
        }
        XCTAssertEqual(firstIterationArray, [0,1,2,3,4,5])
        
        var secondIterationArray = [Int]()
        for value in list {
            secondIterationArray.append(value)
        }
        XCTAssertEqual(secondIterationArray, [0,1,2,3,4,5])
        
        let identityMap = list.map { $0 }
        XCTAssertEqual(identityMap, [0,1,2,3,4,5])
        
        let doubleMap = list.map { $0 * 2 }
        XCTAssertEqual(doubleMap, [0,2,4,6,8,10])
    }
    
    func testForEachNode() {
        let list = LinkedList(start: 0)
        (1...3).forEach { list.append($0) }
        var array = [Int]()
        list.forEachNode { node in
            array.append(node.value)
        }
        XCTAssertEqual(array, [0,1,2,3])
    }
    
    func testRemoveDups21a() {
        let list = LinkedList(start: 0)
        list.append(1)
        list.append(2)
        list.append(2)
        list.append(2)
        list.append(3)
        list.append(4)
        list.append(2)
        list.append(3)
        list.append(4)
        list.append(5)
        list.removeDuplicates()
        XCTAssertEqual(list.map { $0 }, [0, 1,2,3,4,5])
    }
    
    func testRemoveDups21b() {
        let list = LinkedList(start: 0)
        (0...10).forEach { _ in list.append(0) }
        list.removeDuplicates()
        XCTAssertEqual(list.map { $0 }, [0])
    }
    
    func testSubscripting() {
        let list = LinkedList(start: 0)
        (1...9).forEach { list.append($0) }
        XCTAssertEqual(list[0], 0)
        XCTAssertEqual(list[3], 3)
        XCTAssertEqual(list[7], 7)
        XCTAssertEqual(list[9], 9)
    }
    
    func testKthLastElement22a() {
        let list = LinkedList(start: 0)
        (1...9).forEach { list.append($0) }
        let expected = 7
        let actual = list.kthLastElementEasy(k: 3)
        XCTAssertEqual(expected, actual)
    }
    
    func testKthLastElement22b() {
        let list = LinkedList(start: 0)
        (1...9).forEach { list.append($0) }
        let expected = 7
        let actual = list.kthLastElementManual(k: 3)
        XCTAssertEqual(expected, actual)
    }
    
    func testRemoveMiddleNode23() {
        let list = LinkedList(start: 0)
        (1...9).forEach { list.append($0) }
        guard let fourthNode = list.start?.next?.next?.next,
              let sixthNode = fourthNode.next?.next else {
            XCTFail()
            return
        }
        list.removeMiddleNode(fourthNode)
        list.removeMiddleNode(sixthNode)
        let actual = list.map { $0 }
        XCTAssertEqual(actual, [0,1,2,4,6,7,8,9])
    }
    
    func testPartition() {
        let list = LinkedList(start: 3)
        [5,8,5,10,2,1].forEach { list.append($0) }
        print(list.map { $0 })
        list.partitioned(on: 5)
        print(list.map { $0 })
        XCTAssertEqual(list.map { $0 }, [3,2,1,5,8,5,10])
    }
    
    func testSumLinkedLists() {
        let list1 = LinkedList(start: 7)
        [1, 6].forEach { list1.append($0) }
        let list2 = LinkedList(start: 5)
        [9, 2].forEach { list2.append($0) }
        
        let sum = LinkedListQuestions.sumLinkedLists(list1, list2)
        XCTAssertEqual(sum, 912)
    }
    
    func testSumLinkedListsReversed() {
        let list1 = LinkedList(start: 7)
        [1, 6].forEach { list1.append($0) }
        let list2 = LinkedList(start: 5)
        [9, 2].forEach { list2.append($0) }
        
        let sum = LinkedListQuestions.sumLinkedListsReverse(list1, list2)
        XCTAssertEqual(sum, 1308)
    }
    
    func testIsPalindrome() {
        let trueList: LinkedList = ["r", "a", "c", "e", "c", "a", "r"]
        XCTAssertTrue(trueList.isPalindrome())
        let falseList: LinkedList = ["b", "l", "o", "o", "m"]
        XCTAssertFalse(falseList.isPalindrome())
    }
    
    func testIntersectionOne() {
        let list1: LinkedList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let list2: LinkedList = [11, 12, 14]
        let intersection = list1.start?.next?.next?.next?.next?.next?.next
        list2.last?.next = intersection
        
        let actual = LinkedListQuestions.intersection1(list1, list2)
        XCTAssertTrue(actual === intersection)
    }
    
    func testStartOfLoopNode() {
        let list: LinkedList = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let loopStart = list.start?.next?.next?.next
        list.last?.next = loopStart
        let actual = list.startOfLoopNode()
        XCTAssertIdentical(actual, loopStart)
    }
}
