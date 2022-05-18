//
//  StacksAndQueuesTests.swift
//  AlgoTests
//
//  Created by Trevor Adcock on 5/16/22.
//

import XCTest
@testable import Algo

class StacksAndQueuesTests: XCTestCase {

    func testMinStackOne() {
        var stack: StackWithMin = [10, 8, 9, 6, 7, 4, 5, 2, 3, 1, 10, 11]
        XCTAssertEqual(stack.min, 1)
        
        stack.push(-20)
        stack.push(100)
        XCTAssertEqual(stack.min, -20)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 1)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 2)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 8)
    }

    func testMinStackTwo() {
        var stack = StackWithMinEfficient<Int>()
        [10, 8, 9, 6, 7, 4, 5, 2, 3, 1, 10, 11].forEach { stack.push($0) }
        XCTAssertEqual(stack.min, 1)
        
        stack.push(-20)
        stack.push(100)
        XCTAssertEqual(stack.min, -20)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 1)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 2)
        
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        XCTAssertEqual(stack.min, 4)
        
        stack.pop()
        stack.pop()
        stack.pop()
        XCTAssertEqual(stack.min, 8)
    }
    
    func testSetOfStacks() {
        var setOfStacks = SetOfStacks<Int>(substackCapacity: 3)
        (1...10).forEach { setOfStacks.push($0) }
        print(setOfStacks)
        
        let topOne = setOfStacks.stacks[0].peek()
        XCTAssertEqual(topOne, 3)
        
        let topTwo = setOfStacks.stacks[1].peek()
        XCTAssertEqual(topTwo, 6)
        
        let topThree = setOfStacks.stacks[2].peek()
        XCTAssertEqual(topThree, 9)
        
        let topFour = setOfStacks.stacks[3].peek()
        XCTAssertEqual(topFour, 10)
        
        let item = setOfStacks.pop()
        XCTAssertEqual(item, 10)
        // Test cleanup of empty arrays
        XCTAssertEqual(setOfStacks.stacks.count, 3)
    }
    
    func testSetOfStacksPopAtIndex() {
        var setOfStacks = SetOfStacks<Int>(substackCapacity: 3)
        (1...9).forEach { setOfStacks.push($0) }
        
        let middleItem = setOfStacks.pop(at: 1)
        let firstItem = setOfStacks.pop(at: 0)
        XCTAssertEqual(middleItem, 6)
        XCTAssertEqual(firstItem, 3)
        
        XCTAssertEqual(setOfStacks.stacks[0].peek(), 4)
        XCTAssertEqual(setOfStacks.stacks[1].peek(), 8)
        XCTAssertEqual(setOfStacks.stacks[2].peek(), 9)
        XCTAssertEqual(setOfStacks.stacks[0].count, 3)
        XCTAssertEqual(setOfStacks.stacks[1].count, 3)
        XCTAssertEqual(setOfStacks.stacks[2].count, 1)
    }
    
    func testQueueViaStack() {
        var queueViaStack = QueueViaStacks<Int>()
        [1, 2, 3, 4, 5, 6, 7, 8, 9].forEach { queueViaStack.add($0) }
        let firstItem = queueViaStack.remove()
        XCTAssertEqual(firstItem, 1)
        
        [10, 11, 12].forEach { queueViaStack.add($0) }
        let secondItem = queueViaStack.remove()
        XCTAssertEqual(secondItem, 2)
        
        [13, 14, 15].forEach { queueViaStack.add($0) }
        let peekItem = queueViaStack.peek()
        let removedItem = queueViaStack.remove()
        XCTAssertEqual(peekItem, 3)
        XCTAssertEqual(removedItem, 3)
    }
    
    func testStackSort() {
        var stack: Stack<Int> = [8, 19, 1, 9, 27, 0, 34, 2, 6, 8, 9, 3, 100]
        StackAndQueuesQuestions.sort(stack: &stack)
        XCTAssertEqual(stack.data, [100, 34, 27, 19, 9, 9, 8, 8, 6, 3, 2, 1, 0])
    }
    
    func testAnimalShelterQueue() {
        let animalShelterQueue = AnimalShelterQueue()
        animalShelterQueue.enqueue(.init(species: .dog))
        animalShelterQueue.enqueue(.init(species: .cat))
        animalShelterQueue.enqueue(.init(species: .cat))
        animalShelterQueue.enqueue(.init(species: .dog))
        animalShelterQueue.enqueue(.init(species: .cat))
        animalShelterQueue.enqueue(.init(species: .dog))
        animalShelterQueue.enqueue(.init(species: .dog))
        
        let rescueOne = animalShelterQueue.dequeueAny()
        XCTAssertEqual(rescueOne?.species, .dog)
        
        let rescueTwo = animalShelterQueue.dequeueDog()
        XCTAssertEqual(rescueTwo?.species, .dog)
        
        let rescueThree = animalShelterQueue.dequeueAny()
        let rescueFour = animalShelterQueue.dequeueAny()
        let rescueFive = animalShelterQueue.dequeueAny()
        let rescueSix = animalShelterQueue.dequeueAny()
        XCTAssertEqual(rescueThree?.species, .cat)
        XCTAssertEqual(rescueFour?.species, .cat)
        XCTAssertEqual(rescueFive?.species, .cat)
        XCTAssertEqual(rescueSix?.species, .dog)
    }
    
    func testQueueu() {
        var queue = Queue<Int>()
        queue.add(1)
        queue.add(2)
        queue.add(3)
        
        XCTAssertEqual(queue.peek(), 1)
        XCTAssertEqual(queue.remove(), 1)
        queue.add(4)
        XCTAssertEqual(queue.peek(), 2)
    }
}
