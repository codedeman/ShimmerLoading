

## ShimmerView

ShimmerView is a SwiftUI library that provides an easy-to-use, customizable shimmer loading effect for your SwiftUI applications. This library allows you to create loading placeholders similar to those found on popular apps like Facebook and YouTube. The shimmer effect can be applied to any view and can be customized in terms of color and direction.

### Features

- **Generic Implementation**: Apply the shimmer effect to any SwiftUI view.
- **Customizable Colors**: Pass custom colors to match your app's design.
- **Directional Shimmer**: Specify the direction of the shimmer effect (left-to-right, right-to-left, top-to-bottom, bottom-to-top).
- **Easy Integration**: Simple API to integrate shimmer loading in your existing views.

### Installation

To add ShimmerView to your project, you can use Swift Package Manager. In Xcode, go to `File > Swift Packages > Add Package Dependency...` and enter the repository URL:

```
https://github.com/codedeman/ShimmerLoading.git
```

### Usage

#### Basic Usage

```swift
import SwiftUI
import ShimmerLoading

struct ContentView: View {
    @State private var isLoading = true

    var body: some View {
        ScrollView {
            VStack {
                if isLoading {
                    ForEach(0..<3) { _ in
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    isLoading = false
                }
            }
        }
        .padding()
    }
}
```

#### SkeletonView Example

```swift
import SwiftUI

struct SkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ShimmerView(color: Color.white, direction: .leftToRight) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
            }
            .frame(height: 200)
            
            VStack(alignment: .leading, spacing: 8) {
                ShimmerView(color: Color.white, direction: .leftToRight) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                }
                .frame(height: 20)
                
                ShimmerView(color: Color.white, direction: .leftToRight) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 20)
                }
                .frame(height: 20)
                
                ShimmerView(color: Color.white, direction: .leftToRight) {
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
```

#### ShimmerView Customization

```swift
import SwiftUI

enum ShimmerDirection {
    case leftToRight, rightToLeft, topToBottom, bottomToTop
}

struct ShimmerView<Content: View>: View {
    private let content: Content
    private let color: Color
    private let direction: ShimmerDirection
    @State private var gradientPosition: CGFloat = -1.0

    init(color: Color = Color.white, direction: ShimmerDirection = .leftToRight, @ViewBuilder content: () -> Content) {
        self.color = color
        self.direction = direction
        self.content = content()
    }

    var gradient: LinearGradient {
        switch direction {
        case .leftToRight:
            return LinearGradient(gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                                  startPoint: .leading, endPoint: .trailing)
        case .rightToLeft:
            return LinearGradient(gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                                  startPoint: .trailing, endPoint: .leading)
        case .topToBottom:
            return LinearGradient(gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                                  startPoint: .top, endPoint: .bottom)
        case .bottomToTop:
            return LinearGradient(gradient: Gradient(colors: [Color.clear, color.opacity(0.5), Color.clear]),
                                  startPoint: .bottom, endPoint: .top)
        }
    }

    var offsetAnimation: Animation {
        Animation.linear(duration: 1.5).repeatForever(autoreverses: false)
    }

    var body: some View {
        ZStack {
            content
                .hidden()
                .overlay(
                    content
                        .mask(
                            gradient
                                .scaleEffect(2)
                                .rotationEffect(direction == .leftToRight || direction == .rightToLeft ? .degrees(0) : .degrees(90))
                                .offset(x: direction == .leftToRight ? gradientPosition * UIScreen.main.bounds.width : (direction == .rightToLeft ? -gradientPosition * UIScreen.main.bounds.width : 0),
                                        y: direction == .topToBottom ? gradientPosition * UIScreen.main.bounds.height : (direction == .bottomToTop ? -gradientPosition * UIScreen.main.bounds.height : 0))
                        )
                        .animation(offsetAnimation, value: gradientPosition)
                )
        }
        .onAppear {
            gradientPosition = 1.0
        }
    }
}
```
### Demo

![Demo](https://raw.githubusercontent.com/codedeman/ShimmerLoading/main/Sample/Simulator%20Screen%20Recording%20-%20iPhone%2015%20-%202024-06-10%20at%2022.12.56.gif)

### Contributing

Contributions are welcome! Please open an issue or submit a pull request for any bugs or feature requests.

---
