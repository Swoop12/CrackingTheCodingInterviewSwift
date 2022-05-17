//
//  BinaryTree.swift
//  Algo
//
//  Created by Trevor Adcock on 5/17/22.
//

import Foundation
import Combine

public class BinarySearchTreeNode<T: Comparable>: ObservableObject, Equatable {
    
    public static func == (lhs: BinarySearchTreeNode<T>, rhs: BinarySearchTreeNode<T>) -> Bool {
        return lhs.value == rhs.value && lhs.leftChild == rhs.leftChild && lhs.rightChild == rhs.rightChild
    }
    
    
    public typealias Node = BinarySearchTreeNode<T>
    private var subs = Set<AnyCancellable>()
    
    @Published public var value: T
    
    @Published public var leftChild: Node? {
        didSet {
            self.leftChild?.objectWillChange.sink(receiveValue: {
                self.objectWillChange.send()
            }).store(in: &subs)
        }
    }
    
    @Published public var rightChild: Node? {
        didSet {
            self.rightChild?.objectWillChange.sink(receiveValue: {
                self.objectWillChange.send()
            }).store(in: &subs)
        }
    }
    
    // MARK: - INITALIZERS
    
    public init(
        value: T,
        leftChild: Node? = nil,
        rightChild: Node? = nil
    ) {
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.leftChild?.objectWillChange.sink(receiveValue: {
            self.objectWillChange.send()
        }).store(in: &subs)
        self.rightChild?.objectWillChange.sink(receiveValue: {
            self.objectWillChange.send()
        }).store(in: &subs)
    }
    
    public init(_ items: [T]) {
        var elements: [T] = items.reversed()
        self.value = elements.removeLast()
        while let nextValue = elements.popLast() {
            self.insert(nextValue)
        }
    }
    
    // MARK: - INSERT
    public func insert(_ newValue: T) {
        let child = newValue < value ? leftChild : rightChild
        if let child = child {
            child.insert(newValue)
        } else {
            let newNode = Node(value: newValue)
            if newValue < value {
                leftChild = newNode
            } else {
                rightChild = newNode
            }
        }
        objectWillChange.send()
    }
    
    // MARK: - TRAVERSAL
    public func inOrderTraversal(visit: (Node) -> Void) {
        leftChild?.inOrderTraversal(visit: visit)
        visit(self)
        rightChild?.inOrderTraversal(visit: visit)
    }
    
    public func preOrderTraversal(visit: (Node) -> Void) {
        visit(self)
//        objectWillChange.send()
        leftChild?.preOrderTraversal(visit: visit)
        rightChild?.preOrderTraversal(visit: visit)
    }
    
    public func postOrderTraversal(visit: (Node) -> Void) {
        leftChild?.postOrderTraversal(visit: visit)
        rightChild?.postOrderTraversal(visit: visit)
        visit(self)
//        objectWillChange.send()
    }
}
