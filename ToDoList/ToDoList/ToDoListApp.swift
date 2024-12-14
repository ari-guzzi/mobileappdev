//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Ari Guzzi on 12/5/24.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(
            for: ToDoItem.self,
            inMemory: true,
            isAutosaveEnabled: true
        )
    }
}
