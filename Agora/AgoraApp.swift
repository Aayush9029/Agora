//
//  AgoraApp.swift
//  Agora
//
//  Created by Aayush Pokharel on 2023-09-29.
//

import AppKit
import os.log
import SwiftUI

// MARK: - Main App Entry

@main
struct AgoraApp: App {
    // MARK: Properties

    @AppStorage("MENUBARSYMBOL") var menuSymbol: String = "1.circle"
    @AppStorage("MENUBARCOLOR") var menuColor: String = "#EE82B1"
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // MARK: - Body

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
                .background(VisualEffectBlur(material: .sidebar).ignoresSafeArea())
        } label: {
            CreateLabel()
        }
        .menuBarExtraStyle(.window)
    }

    // MARK: - Helper Functions

    @ViewBuilder
    func CreateLabel() -> some View {
        let configuration = NSImage.SymbolConfiguration(pointSize: 16, weight: .light)
            .applying(.init(hierarchicalColor: NSColor(hex: menuColor)))

        if let image = NSImage(systemSymbolName: menuSymbol, accessibilityDescription: nil),
           let updatedImage = image.withSymbolConfiguration(configuration)
        {
            Image(nsImage: updatedImage)
        } else {
            Image(systemName: "questionmark.circle")
        }
    }
}

// MARK: - App Delegate

class AppDelegate: NSObject, NSApplicationDelegate {
    // MARK: Properties

    @AppStorage("MENUBARSYMBOL") var menuSymbol: String = "1.circle"
    @AppStorage("MENUBARCOLOR") var menuColor: String = "#EE82B1"

    // MARK: - Life Cycle Methods

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        os_log("🚪 Launched Agora App %@", log: agoraAppLog, type: .info)
        NSApp.setActivationPolicy(.accessory)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        os_log("🚪 Agora App Will Terminate", log: agoraAppLog, type: .info)
    }

    // MARK: - URL Handling

    func application(_ application: NSApplication, open urls: [URL]) {
        NSApp.setActivationPolicy(.accessory)
        for url in urls {
            os_log("🔍 Received URL: %@", log: agoraAppLog, type: .info, url.absoluteString)
            if let info = MenuInfoModel(url: url) {
                menuSymbol = info.symbol
                menuColor = info.color
            }
        }
    }
}

let agoraAppLog = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.aayush.opensource.Agora", category: "🌐 URL SCHEMES 🌐")
