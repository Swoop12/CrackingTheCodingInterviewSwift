//
//  StackWithMin.swift
//  Algo
//
//  Created by Trevor Adcock on 5/16/22.
//

import Foundation

public struct StackWithMin<T: Comparable>: ExpressibleByArrayLiteral, CustomStringConvertible {
    
    private struct Node {
        let value: T
        let min: T
    }
    
    public typealias ArrayLiteralElement = T
    
    private var data: [Node]
    
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    public var description: String {
        return data.description
    }
    
    public var min: T? {
        return data.last?.min
    }
    
    public init(arrayLiteral elements: T...) {
        var nodes: [Node] = []
        var min: T?
        for element in elements {
            let newMin = Self.minimum(new: element, current: min)
            let node = Node(value: element, min: newMin)
            nodes.append(node)
            min = newMin
        }
        self.data = nodes
    }
    
    public init() {
        self.data = []
    }
    
    @discardableResult
    mutating func pop() -> T? {
        let lastNode = data.popLast()
        return lastNode?.value
    }
    
    mutating func push(_ item: T) {
        let newMin = Self.minimum(new: item, current: min)
        let node = Node(value: item, min: newMin)
        data.append(node)
    }
    
    func peek() -> T? {
        return data.last?.value
    }
    
    private static func minimum(new: T, current: T?) -> T {
        guard let current = current else { return new }
        return current < new ? current : new
    }
}

public struct StackWithMinEfficient<T: Comparable> {
    
    private var minStack: Stack<T>
    private var valueStack: Stack<T>
    
    public init() {
        self.minStack = Stack<T>.init()
        self.valueStack = Stack<T>.init()
    }
    
    public var min: T? {
        return minStack.peek()
    }
    
    @discardableResult
    mutating func pop() -> T? {
        guard let value = valueStack.pop() else { return nil }
        if let min = min {
            if min >= value {
                let _ = minStack.pop()
            }
        }
        return value
    }
    
    mutating func push(_ item: T) {
        if let min = min {
            if item <= min {
                minStack.push(item)
            }
        } else {
            minStack.push(item)
        }
        valueStack.push(item)
    }
    
    func peek() -> T? {
        return valueStack.peek()
    }
}
