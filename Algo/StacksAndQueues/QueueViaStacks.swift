//
//  QueueViaStack.swift
//  Algo
//
//  Created by Trevor Adcock on 5/16/22.
//

import Foundation

/// 3.4 Queue via Stacks: Implement a MyQueue class which implements a queue using two stacks.
public struct QueueViaStacks<T> {
    
    public var newItems: Stack<T> = .init()
    public var shiftedItems: Stack<T> = .init()
    
    public var isEmtpy: Bool {
        newItems.isEmpty && shiftedItems.isEmpty
    }
    
    /// Add an item to the end of the list.
    public mutating func add(_ item: T) {
        newItems.push(item)
    }
    
    /// Remove the first item in the list.
    public mutating func remove() -> T? {
        guard !shiftedItems.isEmpty || !newItems.isEmpty else { return nil }
        if let item = shiftedItems.pop() {
            return item
        } else {
            shiftItems()
            return shiftedItems.pop()
        }
    }
    
    /// Return the top of the queue.
    public mutating func peek() -> T? {
        guard !shiftedItems.isEmpty || !newItems.isEmpty else { return nil }
        if let item = shiftedItems.peek() {
            return item
        } else {
            shiftItems()
            return shiftedItems.peek()
        }
    }
    
    private mutating func shiftItems() {
        while let item = newItems.pop() {
            shiftedItems.push(item)
        }
    }
    
}
