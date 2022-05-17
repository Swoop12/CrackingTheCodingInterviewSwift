//
//  Stack.swift
//  Algo
//
//  Created by Trevor Adcock on 5/15/22.
//

import Foundation

public struct Stack<T>: ExpressibleByArrayLiteral, CustomStringConvertible {
    
    public typealias ArrayLiteralElement = T
    
    var data: [T]
    
    var isEmpty: Bool {
        return data.isEmpty
    }
    
    public var description: String {
        return data.description
    }
    
    public var count: Int {
        return data.count
    }
    
    public init(arrayLiteral elements: T...) {
        self.data = elements
    }
    
    public init() {
        self.data = []
    }
    
    mutating func pop() -> T? {
        return data.popLast()
    }
    
    mutating func push(_ item: T) {
        data.append(item)
    }
    
    func peek() -> T? {
        return data.last
    }
}
