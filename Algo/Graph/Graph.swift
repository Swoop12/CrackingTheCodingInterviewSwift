//
//  BiDirectionalGraph.swift
//  Algo
//
//  Created by Trevor Adcock on 5/17/22.
//

import Foundation

public class GraphNode<T> {

    public typealias Node = GraphNode<T>
    
    public var value: T
    public var neighbors: [Node]
    
    public init(value: T, neighbors: [Node] = []) {
        self.value = value
        self.neighbors = neighbors
    }
    
    /// Performs breadth first iteration over the graph from the given node
    /// - Parameter visit: A closure which is called on each node and return whether the loop should continue.
    public func breadthFirstIteration(visit: (Node) -> Bool) {
        var queue = Queue<Node>()
        queue.add(self)
        while let node = queue.remove() {
            if visit(node) {
                print("Breaking Early")
                break
            }
            for neighbor in node.neighbors {
                queue.add(neighbor)
            }
        }
    }
    
    public func depthFirstIteration(visit: (Node) -> Bool) {
        if visit(self) { return }
        for neighbor in neighbors {
            neighbor.depthFirstIteration(visit: visit)
        }
    }
}
