//
//  ModelContainerStandard.swift
//  ToDoList
//
//  Created by Ari Guzzi on 12/5/24.
//

import SwiftData
import SwiftUI

extension ModelContainer {
    static var standard: ModelContainer {
        let config = ModelConfiguration(
            isStoredInMemoryOnly: false,
            groupContainer: .automatic
        )
        let container = try! ModelContainer(
            for: ToDoItem.self,
            configurations: config
        )
        return container
    }
}
