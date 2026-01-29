//
//  TodoListApp.swift
//  TodoList
//
//  Created by Daniel on 25/1/2026.
//

import SwiftUI
import SwiftData

@main
struct TodoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ToDoItem.self)
        }
    }
}
