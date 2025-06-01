//
//  Tessellations_macOSApp.swift
//  Tessellations macOS
//
//  Created by Charlie Minow on 6/1/25.
//

import SwiftUI

@main
struct Tessellations_macOSApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
