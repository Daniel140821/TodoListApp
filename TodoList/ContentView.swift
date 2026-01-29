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
    @State private var showAddTodoItemSheet :Bool = false

    @State private var NewTodoItemTitle :String = ""
    @FocusState private var NewTodoItemTitleTextFieldFocus: Bool
    
    // 2. 自動查詢並監聽數據變動
    @Query(sort: \ToDoItem.createdAt, order: .reverse) 
    private var items: [ToDoItem]


    func deleteItemByUUID(uuid: UUID) {
        // 先通过 UUID 找到对应的项目
        if let itemToDelete = items.first(where: { $0.id == uuid }) {
            modelContext.delete(itemToDelete)
            // 可选：立即保存更改
            try? modelContext.save()
        }
    }

    // 适配 List 自带的批量删除
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                List {
                    ForEach(items) { item in
                        HStack{
                            Text(item.title)
                                .strikethrough(item.isCompleted)

                            Spacer()

                            Button("Done!"){
                                withAnimation(.easeInOut(duration: 1.0)){
                                    item.isCompleted.toggle()
                                }completion: {
                                    deleteItemByUUID(uuid:item.id)
                                }
                            }
                        }
                    }.onDelete(perform: deleteItems)
                }.scrollContentBackground(.hidden)            
            }
            .padding()
            .frame(maxWidth: .infinity,maxHeight:.infinity)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Todo List")
            .toolbar {
                // 這裡放置工具列內容
                ToolbarItem(placement: .primaryAction) { 
                    Button{
                        showAddTodoItemSheet = true
                    }label:{
                        Image(systemName:"plus")
                    }
                }
            }
        }.sheet(isPresented: $showAddTodoItemSheet){
            VStack{
                Form{
                    TextField(
                        "提醒事項内容",
                        text: $NewTodoItemTitle
                    )
                    .focused($NewTodoItemTitleTextFieldFocus)
                    .onSubmit{
                        NewTodoItemTitleTextFieldFocus = false
                    }
                }
                Button{
                    modelContext.insert( ToDoItem(title:NewTodoItemTitle) )

                    showAddTodoItemSheet = false
                }label:{
                    Text("添加")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity)
                        .frame(height:40)
                }
                .disabled(NewTodoItemTitle.isEmpty ? true : false)
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .buttonBorderShape(.capsule)
                .padding()
            }
            .frame(maxWidth: .infinity,maxHeight:.infinity)
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    ContentView()
}
