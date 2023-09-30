//
//  AppInfoBar.swift
//  Agora
//
//  Created by Aayush Pokharel on 2023-09-29.
//

import SwiftUI

struct AppInfoBar: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(.appIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 48)
            VStack(alignment: .leading, spacing: 0) {
                Text("Agora")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.blue.gradient)
                Text("By Aayush")
                    .foregroundStyle(.secondary)
            }
            .font(.caption)
            Spacer()
            Button("Share", systemImage: "square.and.arrow.up") {}
                .labelStyle(.iconOnly)
                .buttonStyle(.plain)
                .padding(.trailing, 8)
                .foregroundStyle(.secondary)
        }
        .padding(4)
        .background(.gray.opacity(0.125))
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    AppInfoBar()
        .padding()
        .frame(width: 320)
}
