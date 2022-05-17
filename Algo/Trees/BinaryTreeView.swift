//
//  BinaryTreeView.swift
//  Algo
//
//  Created by Trevor Adcock on 5/17/22.
//

import SwiftUI

let nodeHeight: CGFloat = 64

struct NodeView: View {
    
    @ObservedObject var node: BinarySearchTreeNode<NodeData>
    
    var body: some View {
        Rectangle()
            .fill(node.value.isVisited ? Color.blue : Color.red)
            .padding(2)
            .frame(height: nodeHeight)
            .overlay(
                Text(node.value.description)
                    .foregroundColor(.white)
            )
    }
}

struct BinaryTreeView: View {
    
    @ObservedObject var node: BinarySearchTreeNode<NodeData>
    let width: CGFloat
    let onNodeTapped: (BinarySearchTreeNode<NodeData>) -> Void
    
    var body: some View {
        VStack {
            NodeView(node: node)
                .onTapGesture {
                    onNodeTapped(node)
                }
            
            
                HStack(alignment: .top) {
                    if let left = node.leftChild {
                        BinaryTreeView(node: left, width: width/2, onNodeTapped: onNodeTapped)
                    } else {
                        Color.clear
                            .frame(height: nodeHeight)
                    }
                    
                    if let right = node.rightChild {
                        BinaryTreeView(node: right, width: width/2, onNodeTapped: onNodeTapped)
                    } else {
                        Color.clear
                            .frame(height: nodeHeight)
                    }
                }
        }
        .frame(width: width)
    }
}
