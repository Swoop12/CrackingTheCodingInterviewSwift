//
//  ContentView.swift
//  Algo
//
//  Created by Trevor Adcock on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    
    let tree = BinarySearchTreeNode<NodeData>.randomIntTree(nodeCount: 20)
    
    var body: some View {
        BinaryTreeDemo(tree: tree)
    }
}
