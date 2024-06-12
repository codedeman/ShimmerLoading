// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public enum ShimmerDirection {
    case leftToRight, rightToLeft, topToBottom, bottomToTop
}

public struct ShimmerView<Content: View>: View {
    private let content: Content
    private let color: Color
    private let direction: ShimmerDirection
    @State private var gradientPosition: CGFloat = -1.0

    public init(
        color: Color = Color.white,
        direction: ShimmerDirection = .leftToRight,
        @ViewBuilder content: () -> Content
    ) {
        self.color = color
        self.direction = direction
        self.content = content()
    }

    var gradient: LinearGradient {
        switch direction {
        case .leftToRight:
            return LinearGradient(
                gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                startPoint: .leading,
                endPoint: .trailing
            )
        case .rightToLeft:
            return LinearGradient(
                gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                startPoint: .trailing,
                endPoint: .leading
            )
        case .topToBottom:
            return LinearGradient(
                gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                startPoint: .top,
                endPoint: .bottom
            )
        case .bottomToTop:
            return LinearGradient(
                gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
        }
    }

    var offsetAnimation: Animation {
        Animation.linear(duration: 1.5).repeatForever(autoreverses: false)
    }

    public var body: some View {
        ZStack {
            content
                .hidden()
                .overlay(
                    content
                        .mask(
                            gradient
                                .scaleEffect(2)
                                .rotationEffect(direction == .leftToRight || direction == .rightToLeft ? .degrees(0) : .degrees(90))
                                .offset(
                                    x: direction == .leftToRight ? gradientPosition * UIScreen.main.bounds.width : (direction == .rightToLeft ? -gradientPosition * UIScreen.main.bounds.width : 0),
                                    y: direction == .topToBottom ? gradientPosition * UIScreen.main.bounds.height : (direction == .bottomToTop ? -gradientPosition * UIScreen.main.bounds.height : 0)
                                )
                        )
                        .animation(
                            offsetAnimation,
                            value: gradientPosition
                        )
                )
        }
        .onAppear {
            gradientPosition = 1.0
        }
    }
}
