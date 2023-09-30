//
//  ExamplesView.swift
//  Agora
//
//  Created by Aayush Pokharel on 2023-09-29.
//

import SwiftUI

struct ExamplesView: View {
    @AppStorage("AGORAKEY") var key: String = "4432"
    var body: some View {
        VStack(alignment: .leading) {
            Text("Examples")
                .font(.headline)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Group {
                        Example(url: "agora://\(key)?icon=pencil.circle.fill&hex=FF5733")
                        Example(url: "agora://\(key)?icon=bell.fill&hex=33FF57")
                        Example(url: "agora://\(key)?icon=bookmark&hex=EC6342")
                        Example(url: "agora://\(key)?icon=cloud.sun&hex=3478F6")
                    }
                    Group {
                        Example(url: "agora://\(key)?icon=tray&hex=FF00FF")
                        Example(url: "agora://\(key)?icon=camera.fill&hex=7E8186")
                        Example(url: "agora://\(key)?icon=airplane&hex=538BDD")

                        Example(url: "agora://\(key)?icon=star.fill&hex=ECC647")
                    }
                    Group {
                        Example(url: "agora://\(key)?icon=heart.fill&hex=EB563B")
                        Example(url: "agora://\(key)?icon=moon.stars&hex=5733FF")

                        let generated = String(Int.random(in: 9999 ... 99999))
                        Example(url: "agora://\(key)?key=\(generated)")
                    }
                }
            }
            .clipShape(.rect(cornerRadius: 12))
        }
    }
}

struct Example: View {
    @Environment(\.openURL) var openURL
    let url: String

    var body: some View {
        Button {
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(url, forType: .string)

            if let url = URL(string: url) {
                openURL(url)
            }
        } label: {
            Text(url)
                .foregroundStyle(.blue)
                .underline()
                .font(.subheadline)
                .padding(4)
                .padding(.horizontal, 6)
                .background(.blue.opacity(0.125))
                .clipShape(.rect(cornerRadius: 12))
                .multilineTextAlignment(.leading)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ExamplesView()
        .padding()
}
