//
//  SkeletonView.swift
//  ShimmerExample
//
//  Created by Kevin on 6/10/24.
//

import SwiftUI
import ShimmerLoading

struct SkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ShimmerView(color: .blue) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
            }
            .frame(height: 200)

            VStack(alignment: .leading, spacing: 8) {
                ShimmerView(color: .blue) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                }
                .frame(height: 20)

                ShimmerView(color: .blue) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                }
                .frame(height: 20)

                ShimmerView(color: .blue) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                }
                .frame(height: 20)
            }
        }
        .padding()
    }
}
