//
//  FocusBearApp.swift
//  FocusBear
//
//  Created by Jhonatas Willian on 05/02/26.
//

import SwiftUI

@main
struct FocusBearApp: App {
    @StateObject var manager = SprintManager()
    
    var body: some Scene {
        MenuBarExtra {
            MainView(manager: manager)
        } label: {
            let image = manager.isRunning ? "stopwatch.fill" : "stopwatch"
            Image(systemName: image)
        }
        .menuBarExtraStyle(.window)
    }
}
