//
//  GraphsAndTreesTests.swift
//  AlgoTests
//
//  Created by Trevor Adcock on 5/17/22.
//

import Foundation
import XCTest
@testable import Algo

class GraphsAndTreesTests: XCTestCase {
    
    /// 4.1 Route Between Nodes: Given a directed graph, design an algorithm to find out whether there is a route between two nodes.
    func testIsRouteBetween() {
        let end = GraphNode(value: 100)
        let middle = GraphNode(value: 10, neighbors: [end])
        let start = GraphNode(value: 1, neighbors: [middle])
        let trueRoute = GraphQuestions.isRoute(from: start, to: end)
        XCTAssertTrue(trueRoute)
        let floater = GraphNode(value: 0)
        XCTAssertFalse(GraphQuestions.isRoute(from: start, to: floater))
    }
    
    //    4.2 Minimal Tree: Given a sorted (increasing order) array with unique integer elements, write an algorithm to create a binary search tree with minimal height.
    func testTreeFromArray() {
        let items = [1, 2, 3, 4, 5, 6, 7]
        let tree = GraphQuestions.minimalTree(values: items)
        XCTAssertEqual(tree?.value, 4)
        XCTAssertEqual(tree?.leftChild?.value, 2)
        XCTAssertEqual(tree?.rightChild?.value, 6)
        XCTAssertEqual(tree?.leftChild?.rightChild?.value, 3)
        XCTAssertEqual(tree?.leftChild?.leftChild?.value, 1)
        XCTAssertEqual(tree?.rightChild?.leftChild?.value, 5)
        XCTAssertEqual(tree?.rightChild?.rightChild?.value, 7)
        
        
        var depthFirstValues: [Int] = []
        tree?.inOrderTraversal(visit: { node in
            depthFirstValues.append(node.value)
        })
        XCTAssertEqual(depthFirstValues, [1, 2, 3, 4, 5, 6, 7])
    }
    
    func testListForEachLevel() {
        let head = BinarySearchTreeNode(value: 4)
        let left = BinarySearchTreeNode(value: 2)
        let right = BinarySearchTreeNode(value: 6)
        head.leftChild = left
        head.rightChild = right
        left.leftChild = BinarySearchTreeNode(value: 1)
        left.rightChild = BinarySearchTreeNode(value: 3)
        right.leftChild = BinarySearchTreeNode(value: 5)
        right.rightChild = BinarySearchTreeNode(value: 7)
        
        let levelLists = GraphQuestions.listForEachLevel(rootNode: head)
        let levelArray = levelLists.map { list in
            list.map { $0 }
        }
        XCTAssertEqual(
            levelArray,
            [
                [4],
                [2, 6],
                [1, 3, 5, 7]
            ]
        )
    }
    
    func testTreeHeight() {
        let head = BinarySearchTreeNode(value: DepthCount(value: 4))
        let left = BinarySearchTreeNode(value: DepthCount(value: 2))
        let right = BinarySearchTreeNode(value: DepthCount(value: 6))
        head.leftChild = left
        head.rightChild = right
        left.leftChild =    BinarySearchTreeNode(value: DepthCount(value: 1))
        left.rightChild =   BinarySearchTreeNode(value: DepthCount(value: 3))
        right.leftChild =   BinarySearchTreeNode(value: DepthCount(value: 5))
        right.rightChild =  BinarySearchTreeNode(value: DepthCount(value: 7))
        
        let height = GraphQuestions.height(node: head)
        XCTAssertEqual(height, 2)
        let height2 = GraphQuestions.height(node: left)
        XCTAssertEqual(height2, 1)
    }
    
    func testCheckBalanced() {
        let head = BinarySearchTreeNode(value: DepthCount(value: 4))
        let left = BinarySearchTreeNode(value: DepthCount(value: 2))
        let right = BinarySearchTreeNode(value: DepthCount(value: 6))
        head.leftChild = left
        head.rightChild = right
        left.leftChild =    BinarySearchTreeNode(value: DepthCount(value: 1))
        left.rightChild =   BinarySearchTreeNode(value: DepthCount(value: 3))
        right.leftChild =   BinarySearchTreeNode(value: DepthCount(value: 5))
        right.rightChild =  BinarySearchTreeNode(value: DepthCount(value: 7))
        
        XCTAssertEqual(GraphQuestions.checkBalanced(node: head), true)
    }
    
    func testCheckUnbalanced() {
        let head = BinarySearchTreeNode(value: DepthCount(value: 0))
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
            .map { DepthCount(value: $0) }
            .forEach { head.insert($0)}
        XCTAssertFalse(GraphQuestions.checkBalanced(node: head))
        XCTAssertEqual(head.rightChild?.value.height, 12)
    }
    
    func testValidateBinarySearchTree() {
        let head = BinarySearchTreeNode(value: 50)
        [25, 75, 30, 100, 22, 88, 17, 19, 44].forEach { head.insert($0) }
        XCTAssertTrue(GraphQuestions.validate(bst: head))
    }
    
    func testInvalidateBinarySearchTree() {
        let head =  BinarySearchTreeNode(value: 4)
        let left =  BinarySearchTreeNode(value: 2)
        let right = BinarySearchTreeNode(value: 6)
        head.leftChild = left
        head.rightChild = right
        // Invalid Insertion
        left.leftChild =    BinarySearchTreeNode(value: 100)
        left.rightChild =   BinarySearchTreeNode(value: 3)
        right.leftChild =   BinarySearchTreeNode(value: 5)
        right.rightChild =  BinarySearchTreeNode(value: 7)
        
        XCTAssertFalse(GraphQuestions.validate(bst: head))
    }
    
    func testInvalidateTrickyTree() {
        let head =  BinarySearchTreeNode(value: 20)
        let left =  BinarySearchTreeNode(value: 10)
        let right = BinarySearchTreeNode(value: 30)
        head.leftChild = left
        head.rightChild = right
        // Invalid Insertion
        left.rightChild = BinarySearchTreeNode(value: 25)
        XCTAssertFalse(GraphQuestions.validate(bst: head))
    }
}
