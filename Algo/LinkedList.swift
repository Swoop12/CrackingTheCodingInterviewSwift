//
//  LinkedList.swift
//  Algo
//
//  Created by Trevor Adcock on 5/12/22.
//

import Foundation

public class LinkedListNode<T> {
    
    public var value: T
    public var next: LinkedListNode<T>?
    
    public init(value: T, next: LinkedListNode<T>? = nil) {
        self.value = value
        self.next = next
    }
}

public struct LinkedListIterator<T>: IteratorProtocol {
    
    public typealias Node = LinkedListNode<T>
    
    private var iteratorIndex: Node?
    
    public init(head: Node?) {
        self.iteratorIndex = head
    }
    
    public mutating func next() -> T? {
        defer { iteratorIndex = iteratorIndex?.next }
        return iteratorIndex?.value
    }
}

public class LinkedList<T>: Collection, ExpressibleByArrayLiteral {

    public typealias Node = LinkedListNode<T>
    
    public private(set) var start: Node?
    public private(set) var last: Node?
    
    public init(start: T) {
        self.start = Node(value: start)
        self.last = self.start
    }
    
    public init(head: Node) {
        self.start = head
        var end = head
        var endIndex = 0
        while let next = end.next {
            end = next
            endIndex += 1
        }
        self.last = end
        self.endIndex = endIndex
    }
    
    public required init(arrayLiteral elements: T...) {
        var node: Node?
        for (index, value) in elements.enumerated() {
            if node == nil {
                let head = Node(value: value)
                self.start = head
                node = head
            } else {
                let next = Node(value: value)
                node?.next = next
                node = next
                if index == elements.count - 1 {
                    last = next
                }
            }
        }
        endIndex = elements.count
    }
    
    // MARK: - SEQUENCE
    public func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(head: start)
    }
    
    // MARK: - COLLECTION
    public let startIndex: Int = 0
    public private(set) var endIndex: Int = 1
    
    public func index(after i: Int) -> Int {
        i + 1
    }
    
    /// Returns the nth element in the linked list.
    ///
    ///  Time Complexity: runs in O(n) time where n is the position you are indexing
    public subscript(position: Int) -> T {
        guard position >= 0 && position < endIndex,
            var node = start else {
            fatalError("Subscripting linked list out of range")
        }
        for i in (0..<position) {
            guard let next = node.next else {
                fatalError("INDEX \(i); Subscripting linked list out of range")
            }
            node = next
        }
        return node.value
        
    }
    
    public func append(_ value: T) {
        let newNode = Node(value: value)
        if start == nil {
            start = newNode
            last = newNode
        } else {
            last?.next = newNode
            last = newNode
        }
        endIndex += 1
    }
    
    public func forEachNode(action: (Node) -> Void) {
        var pointer: Node? = start
        while let node = pointer {
            action(node)
            pointer = node.next
        }
    }
    
    public func delete(_ node: Node, previous: Node) {
        previous.next = node.next
        endIndex -= 1
    }
    
}

extension LinkedList where T: Equatable {
    
    public func deleteFirstIndex(of value: T) -> Bool {
        if start?.value == value,
           let next = start?.next {
            start = next
            return true
        }
        
        var previous = start
        while let node = previous?.next  {
            if node.value == value {
                previous?.next = node.next
                return true
            }
            previous = node
        }
        return false
    }
}

extension LinkedList where T: Hashable {
    
    public func removeDuplicates() {
        guard var previous = start else { return }
        var foundValues = Set<T>()
        forEachNode { node in
            if foundValues.contains(node.value) {
                delete(node, previous: previous)
            } else {
                foundValues.insert(node.value)
                previous = node
            }
        }
    }
}

extension LinkedList: CustomStringConvertible where T: CustomStringConvertible {
    
    public var description: String {
        var arrayRepresentation: [T] = []
        var node: Node? = start
        while let current = node {
            arrayRepresentation.append(current.value)
            node = current.next
        }
        return arrayRepresentation.description
    }
}

// 2.2 Kth to Last Element
extension LinkedList {
    
    func kthLastElementEasy(k: Int) -> T {
        let kIndex = endIndex - k
        return self[kIndex]
    }
    
    // Approach 1 (save space). Loop over linked list get the count; Find the forward index of K; loop through the linked list again and find the k forward index value
    // Aproach 2 (save marginal time) Loop over the linked list and place each element in a dictionary where the key in the index; Find the count at the end; subtract to find K foward index then just look up that key in the dictionary
    func kthLastElementManual(k: Int) -> T? {
        var indexToValueDict: [Int: T] = [:]
        var index = 0
        var node: Node? = start
        while node != nil {
            indexToValueDict[index] = node?.value
            index += 1
            node = node?.next
        }
        let kthIndex = index - k
        return indexToValueDict[kthIndex]
    }
}

// 2.3 Delete Middle Node
extension LinkedList {
    
    public func removeMiddleNode(_ node: Node) {
        guard let next = node.next else {
            assertionFailure()
            return
        }
        node.value = next.value
        node.next = next.next
        endIndex -= 1
    }
}


//2.4
//Partition: Write code to partition a linked list around a value x, such that all nodes less than x come before all nodes greater than or equal to x. If x is contained within the list, the values of x only need to be after the elements less than x (see below). The partition element x can appear anywhere in the "right partition"; it does not need to appear between the left and right partitions.
extension LinkedList where T: Comparable {
    
    public func partitioned(on value: T) {
        var beforeHead: Node?
        var beforeTail: Node?
        var afterHead: Node?
        var afterTail: Node?
        var pointer: Node? = start
        while let node = pointer {
            if node.value < value {
                if beforeTail != nil {
                    beforeTail?.next = node
                    beforeTail = node
                } else {
                    beforeHead = node
                    beforeTail = node
                }
            } else {
                if afterTail != nil {
                    afterTail?.next = node
                    afterTail = node
                } else {
                    afterHead = node
                    afterTail = node
                }
            }
            pointer = pointer?.next
        }
        beforeTail?.next = afterHead
        if let beforeHead = beforeHead {
            start = beforeHead
        }
        if let afterTail = afterTail {
            last = afterTail
        }
    }
}

//
//Sum Lists: You have two numbers represented by a linked list, where each node contains a single digit. The digits are stored in reverse order, such that the 1's digit is at the head of the list. Write a function that adds the two numbers and returns the sum as a linked list.
//EXAMPLE
//Input: (7-> 1 -> 6) + (5 -> 9 -> 2) .That is,617 + 295. Output:2 -> 1 -> 9.Thatis,912.
//FOLLOW UP
//Suppose the digits are stored in forward order. Repeat the above problem. Input: (6 -> 1 -> 7) + (2 -> 9 -> 5).Thatis,617 + 295. Output:9 -> 1 -> 2.Thatis,912.
public class LinkedListQuestions {
    
    static func sumLinkedLists(_ list1: LinkedList<Int>, _ list2: LinkedList<Int>) -> Int {
        
        var node1: LinkedListNode<Int>? = list1.start
        var node2: LinkedListNode<Int>? = list2.start
        var decimalPlace = 1
        var number: Int = 0
        while node1 != nil || node2 != nil {
            number += ((node1?.value ?? 0) + (node2?.value ?? 0)) * decimalPlace
            node1 = node1?.next
            node2 = node2?.next
            decimalPlace *= 10
        }
        return number
    }
    
    static func sumLinkedListsReverse(_ l1: LinkedList<Int>, _ l2: LinkedList<Int>) -> Int {
        let firstNumber = numberFrom(l1)
        let secondNumber = numberFrom(l2)
        return firstNumber + secondNumber
    }
    
    private static func numberFrom(_ linkedList: LinkedList<Int>) -> Int {
        var pointer: LinkedListNode<Int>? = linkedList.start
        var numString = ""
        while let node = pointer {
            numString.append(String(node.value))
            pointer = node.next
        }
        return Int(numString) ?? 0
    }
}

// 2.6 Palindrome: Implement a function to check if a linked list is a palindrome.
public extension LinkedList where T: Equatable {
    
    func isPalindrome() -> Bool {
        let reversedList = reversed()
        var node: Node? = start
        var reversedNode: Node? = reversedList.start
        while node != nil || reversedNode != nil {
            if node?.value != reversedNode?.value {
                return false
            }
            node = node?.next
            reversedNode = reversedNode?.next
        }
        return true
    }
    
    private func reversed() -> LinkedList {
        // N time
        var values = map { $0 }
        print(values)
        var head: Node?
        var node: Node?
        // N time
        while let value = values.popLast() {
            if let n = node {
                let next = Node(value: value)
                n.next = next
                node = next
            } else {
                let new = Node(value: value)
                node = new
                head = new
            }
        }
        return LinkedList(head: head!)
    }
}

/// 2.7 - Intersection: Given two (singly) linked lists, determine if the two lists intersect. Return the intersecting node. Note that the intersection is defined based on reference, not value. That is, if the kth node of the first linked list is the exact same node (by reference) as the jth node of the second linked list, then they are intersecting.
public extension LinkedListQuestions {
    
    static func intersection1<T>(_ l1: LinkedList<T>, _ l2: LinkedList<T>) -> LinkedListNode<T>? {
        // Create a dictionary of the first linked list where the keys are the nodes memory address and value is the node
        var nodeDict: [UnsafeMutableRawPointer: LinkedListNode<T>] = [:]
        l1.forEachNode { node in
            let nodeAddress = Unmanaged.passUnretained(node).toOpaque()
            nodeDict[nodeAddress] = node
        }
        
        // Loop through the second linked list and see if any of the memory address are in teh dictionary.  If so return that node
        var n2: LinkedListNode<T>? = l2.start
        while let node = n2 {
            let nodeAddress = Unmanaged.passUnretained(node).toOpaque()
            if let intersection = nodeDict[nodeAddress] {
                return intersection
            }
            n2 = node.next
        }
        return nil
    }
}

/// 2.8 - Loop Detection: Given a circular linked list, implement an algorithm that returns the node at the beginning of the loop.
/// DEFINI TION
/// Circular linked list: A (corrupt) linked list in which a node's next pointer points to an earlier node, so as to make a loop in the linked list.
public extension LinkedList {
    
    func startOfLoopNode() -> Node? {
        var nodeAddresses = Set<UnsafeMutableRawPointer>()
        var node: Node? = start
        while let n = node {
            let address = Unmanaged.passUnretained(n).toOpaque()
            if nodeAddresses.contains(address) {
                return n
            }
            nodeAddresses.insert(address)
            node = n.next
        }
        return nil
    }
}
