//
//  AnimalShelterQueue.swift
//  Algo
//
//  Created by Trevor Adcock on 5/17/22.
//

import Foundation

//3.6 Animal Shelter: An animal shelter, which holds only dogs and cats, operates on a strictly "first in, first out"basis. People must adopt either the "oldest"(based on arrival time) of all animals at the shelter, or they can select whether they would prefer a dog or a cat (and will receive the oldest animal of that type). They cannot select which specific animal they would like. Create the data structures to maintain this system and implement operations such as enqueue, dequeueAny, dequeueDog, and dequeueCat. You may use the built-in LinkedList data structure.
class AnimalShelterQueue {
    
    struct Animal {
        
        enum Species: Equatable {
            case dog
            case cat
        }
        
        let species: Species
        let dateIn: Date
        
        public init(species: Species, dateIn: Date = Date()) {
            self.species = species
            self.dateIn = dateIn
        }
    }
    
    var dogQueue = Queue<Animal>()
    var catQueue = Queue<Animal>()
    
    func enqueue(_ animal: Animal) {
        switch animal.species {
        case .dog:
            dogQueue.add(animal)
        case .cat:
            catQueue.add(animal)
        }
    }
    
    func dequeueAny() -> Animal? {
        if let oldestDog = dogQueue.peek(),
           let oldestCat = catQueue.peek() {
            if oldestDog.dateIn < oldestCat.dateIn {
                return dogQueue.remove()
            } else {
                return catQueue.remove()
            }
        } else if !dogQueue.isEmtpy {
            return dogQueue.remove()
        } else {
            return catQueue.remove()
        }
    }
    
    func dequeueDog() -> Animal? {
        return dogQueue.remove()
    }
    
    func dequeueCat() -> Animal? {
        return catQueue.remove()
    }
}
