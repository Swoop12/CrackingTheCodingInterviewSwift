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
    
}
