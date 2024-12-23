//
//  QuoteView.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 09/12/2024.
//

import SwiftUI

struct QuoteView: View {
    @Environment(StateController.self) var stateController: StateController
    var body: some View {
        let quote = stateController.quote
        VStack(alignment: .leading, spacing: 8) {
            Text(quote?.quote ?? "Loading...")
                .font(.title)
                .italic()
                .multilineTextAlignment(.leading)
                .bold()
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .shadow(color: .gray.opacity(0.4), radius: 4, x: 0, y: 2)
                )
            Text("- \(quote?.author ?? "Unknown")")
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.leading, 16)
        }
        .padding()
    }
}

#Preview {
    QuoteView().environment(StateController())
}
