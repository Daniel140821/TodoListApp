//
//  ContentView.swift
//  TodoList
//
//  Created by Daniel on 25/1/2026.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("todoList") private var TodoList : [ToDoItem]=[
        ToDoItem(title:"Test")
    ]
    
    var body: some View {
        NavigationStack{
            VStack {
                List($TodoList) {$todo in
                    Text(todo.title)
                        .strikethrough0(todo.isCompleted)

                    Button("Done!"){
                        todo.isCompleted = !todo
                    }
                }
            
            }
            .padding()
            .navigationTitle("Todo List")
        }
    }
}

#Preview {
    ContentView()
}
