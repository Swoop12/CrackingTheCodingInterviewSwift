//
//  BinaryTreeDemo.swift
//  Algo
//
//  Created by Trevor Adcock on 5/17/22.
//

import SwiftUI

struct NodeData: Comparable, CustomStringConvertible, Equatable {
    
    let value: Int
    var isVisited: Bool = false
    
    public var description: String {
        return value.description
    }
    
    static func < (lhs: NodeData, rhs: NodeData) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func random() -> Self {
        return .init(value: Int.random(in: 0...100))
    }
}


extension BinarySearchTreeNode {
    
    static func randomIntTree(nodeCount: Int) -> BinarySearchTreeNode<NodeData> {
        let root = BinarySearchTreeNode<NodeData>(value: NodeData(value: 50))
        for _ in (0..<nodeCount) {
            let value = Int.random(in: 0...100)
            root.insert(NodeData(value: value))
        }
        return root
    }
}


struct BinaryTreeDemo: View {
    
    @State var tree: BinarySearchTreeNode<NodeData>
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    buttonStack
                    BinaryTreeView(node: tree, width: proxy.size.width) { node in
                        withAnimation {
                            tree = node
                        }
                    }
                    
                    
                }
                .onReceive(tree.objectWillChange) { output in
                    print("Recieved value")
                }
            }
        }
    }
    
    var buttonStack: some View {
        HStack(spacing: 24) {
            Button("In Order Traversal") {
                DispatchQueue.global().async {
                    tree.inOrderTraversal { node in
                        DispatchQueue.main.async {
                            node.value.isVisited.toggle()
                        }
                        Thread.sleep(forTimeInterval: 0.3)
                    }
                }
            }
            
            Button("Pre Order Traversal") {
                DispatchQueue.global().async {
                    tree.preOrderTraversal { node in
                        DispatchQueue.main.async {
                            node.value.isVisited.toggle()
                        }
                        Thread.sleep(forTimeInterval: 0.3)
                    }
                }
            }
            
            Button("Post Order Traversal") {
                DispatchQueue.global().async {
                    tree.postOrderTraversal { node in
                        DispatchQueue.main.async {
                            node.value.isVisited.toggle()
                        }
                        Thread.sleep(forTimeInterval: 0.3)
                    }
                }
            }
            
            Button("Breadth First Traversal") {
                DispatchQueue.global().async {
                    tree.breadthFirstIteration { node in
                        DispatchQueue.main.async {
                            node.value.isVisited.toggle()
                        }
                        Thread.sleep(forTimeInterval: 0.3)
                    }
                }
            }
            
            Button("Insert Random") {
                tree.insert(NodeData.random())
            }
            
            Button("Reset") {
                tree.postOrderTraversal { node in
                    node.value.isVisited = false
                }
            }
        }
        .padding()
    }
}
