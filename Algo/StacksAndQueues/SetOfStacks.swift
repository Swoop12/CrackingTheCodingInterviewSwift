//
//  StackOfPlates.swift
//  Algo
//
//  Created by Trevor Adcock on 5/16/22.
//

import Foundation

public struct SetOfStacks<T: Comparable>: CustomStringConvertible {
    
    let substackCapacity: Int
    var stacks: [Stack<T>]
    
    public init(substackCapacity: Int) {
        self.substackCapacity = substackCapacity
        let initialStack = Stack<T>()
        self.stacks = [initialStack]
    }
    
    public var description: String {
        return stacks.description
    }
    
    public mutating func push(_ item: T) {
        guard let currentStack = stacks.last else {
            stacks.append([item])
            return
        }
        if currentStack.count >= substackCapacity {
            pushNewStack()
        }
        stacks[stacks.count - 1].push(item)
    }
    
    public mutating func pop() -> T? {
        let value = stacks[stacks.count - 1].pop()
        if stacks[stacks.count - 1].isEmpty {
            stacks.removeLast()
        }
        return value
    }
    
    public mutating func pop(at index: Int) -> T? {
        guard stacks.count > index else { return nil }
        let value = stacks[index].pop()
        shiftValuesDown(from: index)
        return value
    }
    
    private mutating func shiftValuesDown(from index: Int) {
        var workingStack = Stack<T>()
        let iterations = (stacks.count - (index + 1)) * substackCapacity
        for _ in (0..<iterations) {
            if let item = pop() {
                workingStack.push(item)
            }
        }
        while let value = workingStack.pop() {
            push(value)
        }
    }
    
    private mutating func pushNewStack() {
        let newStack = Stack<T>()
        self.stacks.append(newStack)
    }
}
