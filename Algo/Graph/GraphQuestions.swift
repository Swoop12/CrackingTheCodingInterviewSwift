//
//  GraphQuestions.swift
//  Algo
//
//  Created by Trevor Adcock on 5/17/22.
//

import Foundation

public struct DepthCount: Comparable {
    let value: Int
    var height: Int?
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.value < rhs.value
    }
}

public class GraphQuestions {
    
    public typealias Node = GraphNode<Int>
    
    /// 4.1 Route Between Nodes: Given a directed graph, design an algorithm to find out whether there is a route between two nodes.
    public static func isRoute(from a: Node, to b: Node) -> Bool {
        var found: Bool = false
        a.breadthFirstIteration { node in
            print(node.value)
            if node === b {
                found = true
                return true
            } else {
                return false
            }
        }
        return found
    }

    // MARK: - 4.2 Minimal Tree
    // Given a sorted (increasing order) array with unique integer elements, write an algorithm to create a binary search tree with minimal height.
    public static func minimalTree<Values: RandomAccessCollection>(values: Values) -> BinarySearchTreeNode<Int>? where Values.Element == Int, Values.Index == Int {
        guard !values.isEmpty else { return nil }
        print("Iterating WIth: ", values)
        let middleIndex = values.count/2
        let middleValue = values[middleIndex]
        let node = BinarySearchTreeNode(value: middleValue)
        let leftSlice = values.prefix(upTo: middleIndex)
        let rightSlice = values.suffix(from: middleIndex+1)
        // TODO: - Fix to use the original array to avoid the time and space complexity that comes with this
        let leftNode = minimalTree(values: Array(leftSlice))
        let rightNode = minimalTree(values: Array(rightSlice))
        node.leftChild = leftNode
        node.rightChild = rightNode
        return node
    }
    
    // MARK: - 4.3 List of Depths
    /// 4.3 List of Depths: Given a binary tree, design an algorithm which creates a linked list of all the nodes at each depth (e.g., if you have a tree with depth D, you'll have Dlinked lists).
    public static func listForEachLevel(rootNode: BinarySearchTreeNode<Int>) -> [LinkedList<Int>] {
        var levels: [LinkedList<Int>] = []
        var currentLevel = [rootNode]
        while !currentLevel.isEmpty {
            levels.append(list(level: currentLevel))
            currentLevel = children(of: currentLevel)
        }
        return levels
    }
    
    private static func list(level: [BinarySearchTreeNode<Int>]) -> LinkedList<Int> {
        let list: LinkedList<Int> = []
        for node in level {
            list.append(node.value)
        }
        return list
    }
    
    private static func children(of nodes: [BinarySearchTreeNode<Int>]) -> [BinarySearchTreeNode<Int>] {
        var childs: [BinarySearchTreeNode<Int>] = []
        for node in nodes {
            if let left = node.leftChild {
                childs.append(left)
            }
            if let right = node.rightChild {
                childs.append(right)
            }
        }
        return childs
    }
    
    // MARK: - 4.4 Check Balanced
    // Implement a function to check if a binary tree is balanced. For the purposes of this question, a balanced tree is defined to be a tree such that the heights of the two subtrees of any node never differ by more than one.
    
    public static func checkBalanced(node: BinarySearchTreeNode<DepthCount>?) -> Bool {
        guard let node = node else { return true }
        if abs(height(node: node.leftChild) - height(node: node.rightChild)) > 1 ||
            !checkBalanced(node: node.leftChild) ||
            !checkBalanced(node: node.rightChild)
        {
            return false
        }
        return true
    }
    
    static func height(node: BinarySearchTreeNode<DepthCount>?) -> Int {
        if let height = node?.value.height {
            return height
        }
        guard let node = node else { return 0 }
        if node.leftChild == nil && node.rightChild == nil {
            node.value.height = 0
            return 0
        } else {
            let leftHeight = height(node: node.leftChild)
            let rightHeight = height(node: node.rightChild)
            let h = max(leftHeight, rightHeight) + 1
            node.value.height = h
            return h
        }
    }
    
    // MARK: - 4.5 Validate Binary Search Tree
    // Implement a function to check if a binary tree is a binary search tree.
    public static func validate(
        bst: BinarySearchTreeNode<Int>?,
        min: Int = Int.min,
        max: Int = Int.max
    ) -> Bool {
        guard let bst = bst else { return true }
        if bst.value < min || bst.value > max { return false }
        if let left = bst.leftChild,
           left.value >= bst.value {
            return false
        }
        if let right = bst.rightChild,
           right.value < bst.value {
            return false
        }
        return validate(bst: bst.leftChild, min: min, max: bst.value) &&
        validate(bst: bst.rightChild, min: bst.value, max: max)
    }
    
    // MARK: - 4.6 Successor
    // Write an algorithm to find the "next" node (i.e., in-order successor) of a given node in a binary search tree. You may assume that each node has a link to its parent.
    public static func successor(for node: BinarySearchTreeNode<Int>) -> BinarySearchTreeNode<Int>? {
        if let right = node.rightChild {
            return leftMostChild(for: right)
        } else {
            var q: BinarySearchTreeNode<Int>? = node
            var x = node.parent
            while x != nil && x?.leftChild !== q {
                q = x
                x = x?.parent
            }
            return x
        }
    }
    
    private static func leftMostChild(for node: BinarySearchTreeNode<Int>) -> BinarySearchTreeNode<Int> {
        var n = node
        while let left = n.leftChild {
            n = left
        }
        return n
    }
    
    // MARK: - 4.7 - TODO: - Fix both of these
    // Build Order: You are given a list of projects and a list of dependencies (which is a list of pairs of projects, where the second project is dependent on the first project). All of a project's dependencies must be built before the project is. Find a build order that will allow the projects to be built. If there is no valid build order, return an error.
    //  EXAMPLE Input:
    // projects: a, b, c, d, e, f
    // dependencies: (a, d), (f, b), (b, d), (f, a), (d, c) Output: f, e, a, b, d, c
    
    struct Project {
        let name: String
        var remainingDependencies: Int = 0
    }
    
    public static func buildOrder(projects: [String], dependencies: [(String, String)]) throws -> [String] {
        let nodes = buildGraph(projects: projects, dependencyGraph: dependencies)
        
        /// O(numProjects*maxNumDependecies)
        // 2. Loop through each item in the array and traverse graph until you find a item with no dependencies
        var projectOrder: [String] = []
        var remaining = Array(nodes.values)
        while projectOrder.count != projects.count {
            let buildables = buildableProjects(in: &remaining)
            if buildables.isEmpty { throw NSError(domain: "No valid build order", code: 100) }
            projectOrder.append(contentsOf: buildables.map { $0.value.name })
            for buildable in buildables {
                for neighbor in buildable.neighbors {
                    neighbor.value.remainingDependencies -= 1
                }
            }
        }
        return projectOrder
    }
    
    private static func buildGraph(projects: [String], dependencyGraph: [(String, String)]) ->[String: GraphNode<Project>] {
        
        /// O(numProjects + numDependecies)
        // 1. Build a unidirectional graph out of the projects where each edge represents a dependent project. (Every project points to its dependencies
        var nodes: [String: GraphNode<Project>] = [:]
        for projectName in projects {
            let project = Project(name: projectName)
            let node = GraphNode<Project>(value: project)
            nodes[projectName] = node
        }
        
        for pair in dependencyGraph {
            guard let dependency = nodes[pair.0],
                  let dependent = nodes[pair.1] else { continue }
            dependency.neighbors.append(dependent)
            dependent.value.remainingDependencies += 1
        }
        return nodes
    }
    
    private static func buildableProjects(in nodes: inout [GraphNode<Project>]) -> [GraphNode<Project>] {
        var buildable: [GraphNode<Project>] = []
        var toRemove: [Int] = []
        for (i, node) in nodes.enumerated() {
            if node.value.remainingDependencies == 0 {
                buildable.append(node)
                toRemove.append(i)
            }
        }
        nodes.remove(atOffsets: IndexSet(toRemove))
        return buildable
    }
    
    public static func buildOrderDictionaries(projects: [String], dependencies: [(String, String)]) throws -> [String] {
        var dictionary: [String: Set<String>] = [:]
        for project in projects {
            dictionary[project] = []
        }
        for pair in dependencies {
            let dependency = pair.0
            let dependent = pair.1
            var items = dictionary[dependent] ?? []
            items.insert(dependency)
            dictionary[dependent] = items
        }
        var buildOrder: [String] = []
        var completed = Set<String>()
        for project in projects {
            let order = minimalBuildOrder(project: project, completed: completed, projectGraph: dictionary)
            buildOrder.append(contentsOf: order)
            order.forEach { completed.insert($0) }
        }
        return buildOrder
    }
    
    private static func minimalBuildOrder(project: String, completed: Set<String>, projectGraph: [String: Set<String>]) -> [String] {
        guard let deps = projectGraph[project],
              !completed.contains(project) else { return [] }
        let remaining = deps.subtracting(completed)
        if remaining.isEmpty {
            return [project]
        } else {
            let order = remaining.flatMap { minimalBuildOrder(project: $0, completed: completed, projectGraph: projectGraph) }
            return order + [project]
        }
    }
    
    // MARK: - 4.8
    // First Common Ancestor: Design an algorithm and write code to find the first common ancestor of two nodes in a binary tree. Avoid storing additional nodes in a data structure. NOTE:This is not necessarily a binary search tree.
    public static func firstCommonAnncestor<T>(node1: BinarySearchTreeNode<T>, node2: BinarySearchTreeNode<T>) -> BinarySearchTreeNode<T>? {
        let node1Depth = depth(of: node1)
        let node2Depth = depth(of: node2)
        var (deeperNode, shallowerNode) = node1Depth > node2Depth ? (node1, node2) : (node2, node1)
        let depthDifference = abs(node1Depth - node2Depth)
        for _ in (0..<depthDifference) {
            if let parent = deeperNode.parent {
                deeperNode = parent
            }
        }
        
        if deeperNode === shallowerNode {
            return deeperNode
        }
        
        while let node1Parent = deeperNode.parent,
              let node2Parent = shallowerNode.parent {
            if node1Parent === node2Parent {
                return node1Parent
            } else {
                deeperNode = node1Parent
                shallowerNode = node2Parent
            }
        }
        return nil
    }
    
    private static func depth<T>(of node: BinarySearchTreeNode<T>) -> Int {
        var depth: Int = 0
        var n = node
        while let parent = n.parent {
            depth += 1
            n = parent
        }
        return depth
    }
    
    // MARK: - 4.9 BST Sequences:
    // A binary search tree was created by traversing through an array from left to right and inserting each element. Given a binary search tree with distinct elements, print all possible arrays that could have led to this tree.
    public static func btsSequence(root: BinarySearchTreeNode<Int>) -> [[Int]] {
        let children = [root.leftChild, root.rightChild].compactMap { $0 }
        return possibleOptions(runningOrder: [root.value], availableNextChildren: Set(children))
    }
    
    private static func possibleOptions(runningOrder: [Int], availableNextChildren: Set<BinarySearchTreeNode<Int>>) -> [[Int]] {
        if availableNextChildren.isEmpty {
            return [runningOrder]
        }
        var timelines: [[Int]] = []
        for nextChild in availableNextChildren {
            var children = availableNextChildren
            children.remove(nextChild)
            if let left = nextChild.leftChild {
                children.insert(left)
            }
            if let right = nextChild.rightChild {
                children.insert(right)
            }
            var newOrder = runningOrder
            newOrder.append(nextChild.value)
            let timeline = possibleOptions(runningOrder: newOrder, availableNextChildren: children)
            timelines += timeline
        }
        return timelines
    }
}

extension BinarySearchTreeNode: Hashable where T: Hashable{
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}
