//
//  StackAndQueuesQuestions.swift
//  Algo
//
//  Created by Trevor Adcock on 5/15/22.
//

import Foundation

//3.2 Stack Min: How would you design a stack which, in addition to push and pop, has a function min
//which returns the minimum element? Push, pop and min should all operate in 0(1) time.
public class StackAndQueuesQuestions {
    
    /// 3.1 - Three in One: Describe how you could use a single array to implement three stacks. Hints: #2, #72, #38, #58
    ///
    // Every third item tracks to one of the stacks. so index 0, 3, 6, 9 etc... are dedicated to Stack 1.  indecies 1, 4, 7, 10... are dedicated to stack 2, and 2, 5, 8, 11... etc are dedicated to stack three.
    // Keep track of the last index we appended to / removed from for each stack
    struct ThreeStacksInOne<T> {
        
        public init() {
            self.data = []
        }
        
        struct InnerStack<T> {
            
            private var startIndex: Int
            private var count: Int = 0
            
            init(startIndex: Int) {
                self.startIndex = startIndex
            }
            
            public mutating func push(_ item: T, into array: inout [T?]) {
                let index = count * 3 + startIndex
                if index >= array.count {
                    array.append(contentsOf: [nil, nil, nil])
                }
                array[index] = item
                count += 1
            }
            
            public mutating func pop(from array: inout [T?]) -> T? {
                let index = (count - 1) * 3 + startIndex
                let value = array[index]
                array[index] = nil
                count -= 1
                // TODO: - Implement sizing down the array if the last 3 elements are nil
                return value
            }
        }
        
        var data: [T?]
        
        public var stackOne: InnerStack<T> = .init(startIndex: 0)
        public var stackTwo: InnerStack<T> = .init(startIndex: 1)
        public var stackThree: InnerStack<T> = .init(startIndex: 2)
    }
    
    
}
