//
//  ContentView.swift
//  Algo
//
//  Created by Trevor Adcock on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    
    let tree = BinarySearchTreeNode<NodeData>.randomIntTree(nodeCount: 20)
    let testTree = GraphQuestions.minimalTree(values: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14])!
    
    var body: some View {
        BinaryTreeDemo(tree: tree)
    }
}
