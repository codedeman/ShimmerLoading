//
//  ContentView.swift
//  ShimmerExample
//
//  Created by Kevin on 6/10/24.
//

import SwiftUI
import ShimmerLoading

struct ContentView: View {
    @State private var isLoading = true

    var body: some View {
        ScrollView {
            VStack {
                if isLoading {
                    ForEach(0..<10) { _ in
                        SkeletonView()
                            .padding(.bottom, 16)
                    }
                } else {
                    // Replace with your actual content
                    Text("Content Loaded")
                        .padding()
                }
            }
            .onAppear {
                // Simulate loading delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 100) {
                    isLoading = false
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}



struct ShimmerPlaceholder: View {
    var color: Color

    var body: some View {
        ShimmerView(color: color) {
            VStack(alignment: .leading, spacing: 10) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 20)

                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 20)

                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 20)
            }
            .padding()
        }
        .frame(height: 100)
    }
}
