//
//  MenuBarSchemeRow.swift
//  Agora
//
//  Created by Aayush Pokharel on 2023-09-29.
//

import SwiftUI

struct MenuBarSchemeRow<Content: View>: View {
    let settingName: String
    let query: String
    let rule: String?
    let content: Content

    init(_ settingName: String, query: String, rule: String? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.settingName = settingName
        self.query = query
        self.content = content()
        self.rule = rule
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(settingName)
                    .font(.headline)
                Spacer()
                content
            }
            HStack(spacing: 0) {
                Text("agora://")
                    .foregroundStyle(.tertiary)
                Text("<key>")
                    .foregroundStyle(.secondary)
                Text("?")
                    .foregroundStyle(.tertiary)
                Text("\(query)")
                    .foregroundStyle(.primary)
            }
            .font(.subheadline)
            if let rule {
                HStack(spacing: 4) {
                    Text("Note:")
                    Text(rule)
                        .foregroundStyle(.orange)
                }
                .font(.caption2)
                .padding(.horizontal, 6)
                .padding(4)
                .background(.orange.opacity(0.125))
                .clipShape(.capsule)
            }

            Divider()
        }
    }
}

struct ValueModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(.blue.opacity(0.25))
            .clipShape(.rect(cornerRadius: 6))
            .font(.callout)
    }
}

#Preview {
    VStack {
        MenuBarSchemeRow("Color", query: "hex=<color>") {
            Color(nsColor: NSColor(hex: "#FF0000"))
                .clipShape(.circle)
                .frame(width: 16, height: 16)
        }

        MenuBarSchemeRow(
            "Key",
            query: "key=<new_key>",
            rule: "newKey must be number and > 10000 ")
        {
            Text("4232")
                .modifier(ValueModifier())
        }
    }
    .padding()
}
