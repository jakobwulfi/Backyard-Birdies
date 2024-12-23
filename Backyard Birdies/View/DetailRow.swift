//
//  DetailRow.swift
//  Backyard Birdies
//
//  Created by dmu mac 31 on 12/12/2024.
//

import SwiftUI

struct DetailRow: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(content)
                .font(.title3)
                .bold()
        }
    }
}

