//
//  StackAndQueuesQuestions.swift
//  Algo
//
//  Created by Trevor Adcock on 5/15/22.
//

import Foundation

public class StackAndQueuesQuestions {
    
    
    /// 3.5 Sort Stack: Write a program to sort a stack such that the smallest items are on the top. You can use an additional temporary stack, but you may not copy the elements into any other data structure (such as an array).The stack supports the following operations: push, pop, peek, and isEmpty.
    public static func sort<T: Comparable>(stack: inout Stack<T>) {
        var tempStack = Stack<T>()
        while let value = stack.pop() {
            while let tempTop = tempStack.peek(),
                  tempTop > value {
                stack.push(tempStack.pop()!)
            }
            tempStack.push(value)
        }
        
        // Reshuffle all the elements back onto the original stack
        while let value = tempStack.pop() {
            stack.push(value)
        }
    }
}
