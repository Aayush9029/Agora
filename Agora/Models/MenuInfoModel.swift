//
//  MenuInfoModel.swift
//  Agora
//
//  Created by Aayush Pokharel on 2023-09-29.
//
import os.log
import SwiftUI

struct MenuInfoModel {
    let menuInfoLog = OSLog(subsystem: Bundle.main.bundleIdentifier ?? "com.aayush.opensource.Agora", category: "🌐 URL SCHEMES 🌐")

    @AppStorage("MENUBARSYMBOL") var symbol: String = "1.circle" {
        didSet {
            os_log("🔄 Symbol changed to: %@", log: menuInfoLog, type: .info, symbol)
        }
    }
      
    @AppStorage("MENUBARCOLOR") var color: String = "#EE82B1" {
        didSet {
            os_log("🎨 Color changed to: %@", log: menuInfoLog, type: .info, color)
        }
    }
      
    @AppStorage("AGORAKEY") var key: String = "4432" {
        didSet {
            if key.count < 3 || key.count > 8 {
                os_log("🚫 Invalid key length: %@", log: menuInfoLog, type: .error, key)
            } else {
                os_log("🔑 Key changed to: %@", log: menuInfoLog, type: .info, key)
            }
        }
    }

    init(symbol: String, color: String) {
        self.symbol = symbol
        self.color = color
    }
    
    init?(url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems,
              let urlKey = components.host, urlKey == key
        else {
            os_log("❌ Invalid key or missing parameters in URL: %@", log: menuInfoLog, type: .error, url.absoluteString)
            self.symbol = MenuInfoModel.lock.symbol
            self.color = MenuInfoModel.lock.color
            return nil
        }
        
        if let symbol = queryItems.first(where: { $0.name == "icon" })?.value {
            self.symbol = symbol
        }
        
        if let color = queryItems.first(where: { $0.name == "hex" })?.value {
            self.color = "#" + color
        }
        
        if let newKey = queryItems.first(where: { $0.name == "key" })?.value {
            self.key = newKey
        }
    }
    
    static var error: MenuInfoModel = .init(symbol: "exclamationmark.circle.fill", color: "#FF0000")
    static var lock: MenuInfoModel = .init(symbol: "lock.fill", color: "61C4D3")
}
