//
//  BinaryTree.swift
//  Algo
//
//  Created by Trevor Adcock on 5/17/22.
//

import Foundation
import Combine

public class BinarySearchTreeNode<T: Comparable>: ObservableObject, Equatable, Comparable {
    
    public static func < (lhs: BinarySearchTreeNode<T>, rhs: BinarySearchTreeNode<T>) -> Bool {
        return lhs.value < rhs.value
    }
    
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
    
    weak var parent: Node?
    
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
            newNode.parent = self
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
        leftChild?.preOrderTraversal(visit: visit)
        rightChild?.preOrderTraversal(visit: visit)
    }
    
    public func postOrderTraversal(visit: (Node) -> Void) {
        leftChild?.postOrderTraversal(visit: visit)
        rightChild?.postOrderTraversal(visit: visit)
        visit(self)
    }
    
    public func depthFirstSearch(for item: T) -> Node? {
        if value == item {
            return self
        } else if let left = leftChild?.depthFirstSearch(for: item) {
            return left
        } else if let right = rightChild?.depthFirstSearch(for: item) {
            return right
        } else {
            return nil
        }
    }
    
    public func breadthFirstIteration(visit: (Node) -> Void) {
        // CHEATING WITH AN ARRAY HERE SINCE OUR QUEUE ISN'T THREAD SAFE
        var nodes: [Node] = [self]
        while !nodes.isEmpty {
            let current: Node = nodes.removeFirst()
            visit(current)
            if let leftChild = current.leftChild {
                nodes.append(leftChild)
            }
            if let rightChild = current.rightChild {
                nodes.append(rightChild)
            }
        }
    }
    
    public func breadthFirstSearch(for item: T) -> Node? {
        var queue = Queue<Node>()
        queue.add(self)
        while let current = queue.remove() {
            if current.value == item { return current }
            if let leftChild = current.leftChild {
                queue.add(leftChild)
            }
            if let rightChild = current.rightChild {
                queue.add(rightChild)
            }
        }
        return nil
    }
}
