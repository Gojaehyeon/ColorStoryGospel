//
//  ColorStoryApp.swift
//  ColorStory
//
//  Created by 고재현 on 5/15/25.
//

import SwiftUI

@main
struct ColorStoryApp: App {
    @StateObject private var settings = SettingsViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(settings)
        }
    }
}
