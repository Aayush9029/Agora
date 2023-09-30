//
//  MenuBarView.swift
//  Agora
//
//  Created by Aayush Pokharel on 2023-09-29.
//

import SwiftUI

struct MenuBarView: View {
    @AppStorage("MENUBARSYMBOL") var menuSymbol: String = "1.circle"
    @AppStorage("MENUBARCOLOR") var menuColor: String = "#EE82B1"
    @AppStorage("AGORAKEY") var key: String = "4432"

    var body: some View {
        VStack(alignment: .leading) {
            MenuBarSchemeRow(
                "Symbol",
                query: "icon=<symbol>",
                rule: "Use a valid SFSymbol name in place of <symbol>"
            ) {
                Image(systemName: menuSymbol)
            }

            MenuBarSchemeRow(
                "Color",
                query: "hex=<color>",
                rule: "Use a valid hex color code in place of <color>, omit '#'"
            ) {
                Color(nsColor: NSColor(hex: menuColor))
                    .clipShape(.circle)
                    .frame(width: 16, height: 16)
            }

            MenuBarSchemeRow(
                "Key",
                query: "key=<new_key>",
                rule: "Use any word of 8 letters or fewer for <new_key>"
            ) {
                Text(key)
                    .modifier(ValueModifier())
            }

            ExamplesView()

            AppInfoBar()
        }
        .padding()
        .frame(width: 360, height: 520)
    }
}

#Preview {
    MenuBarView()
}
