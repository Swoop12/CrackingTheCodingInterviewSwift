//
//  Queue.swift
//  Algo
//
//  Created by Trevor Adcock on 5/15/22.
//

import Foundation

public struct Queue<T>: ExpressibleByArrayLiteral, CustomStringConvertible {
    
    private class Node<T> {
        var value: T
        var next: Node<T>?
        
        init(
            value: T,
             next: Node<T>? = nil
        ) {
            self.value = value
            self.next = next
        }
    }
    
    private var front: Node<T>?
    private var back: Node<T>?
    
    public init(arrayLiteral elements: T...) {
        var items = elements
        while let value = items.popLast() {
            let node = Node(value: value)
            if back != nil {
                back?.next = node
                back = node
            } else {
                front = node
                back = node
            }
        }
    }
    
    public var isEmtpy: Bool {
        front == nil
    }
    
    /// Add an item to the end of the list.
    public mutating func add(_ item: T) {
        let node = Node(value: item)
        if let b = back {
            b.next = node
            self.back = node
        } else {
            front = node
            back = node
        }
    }
    
    /// Remove the first item in the list.
    public mutating func remove() -> T? {
        let value = front?.value
        if front === back {
            back = nil
        }
        front = front?.next
        return value
    }
    
    /// Return the top of the queue.
    func peek() -> T? {
        return front?.value
    }
    
    public var description: String {
        var values: [T] = []
        var node = front
        while let value = node?.value {
            values.append(value)
            node = node?.next
        }
        return values.description
    }
}
