//
//  ContentView.swift
//  TodoList
//
//  Created by Daniel on 25/1/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    // 2. 自動查詢並監聽數據變動
    @Query(sort: \ToDoItem.createdAt, order: .reverse) 
    private var items: [ToDoItem]
    
    var body: some View {
        NavigationStack{
            VStack {
                List($TodoList) {$todo in
                    HStack{
                        Text(todo.title)
                            .strikethrough0(todo.isCompleted)

                        Button("Done!"){
                            item.isCompleted.toggle()
                            for index in offsets {
                                modelContext.delete(items[index]) // 刪除數據
                            }           
                        }
                    }.onDelete(perform: deleteItems)
                }
            
            }
            .padding()
            .navigationTitle("Todo List")
            .toolbar {
        // 這裡放置工具列內容
        ToolbarItem(placement: .primaryAction) { 
            Button{
                modelContext.insert(ToDoItem(title: "新的任務 \(items.count + 1)"))
            }label:{
                Image(systemName:"plus")
            }
        }
    }
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index]) // 刪除數據
        }
    }
}

#Preview {
    ContentView()
}
