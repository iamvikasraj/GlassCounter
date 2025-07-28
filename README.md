# Glass Button SwiftUI

A beautiful, interactive glass morphism button component built with SwiftUI featuring smooth animations, realistic glass effects, and a fun counting animation.

## ✨ Features

- **Glass Morphism Design**: Realistic frosted glass appearance with subtle transparency and blur effects
- **Interactive Animations**: Smooth press animations with scale transformations and shadow changes
- **Gradient Strokes**: Multiple layered gradients for authentic glass-like borders
- **Counting Animation**: Animated progress counter from 00 to 100 with spring animations
- **Customizable**: Easy to modify colors, corner radius, and animation parameters
- **Responsive**: Adapts to different screen sizes with proper scaling

## 🎥 Demo

The button cycles through three states:
1. **Initial**: "Wanna Count?" - Ready to start
2. **Counting**: "00" → "100" - Animated counter with spring transitions
3. **Complete**: "Yayyyyyy!!!" → "Once Again?" - Celebration and reset

## 🚀 Installation

### Swift Package Manager
Add this to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/glass-button-swiftui.git", from: "1.0.0")
]
```

### Manual Installation
1. Download the source files
2. Add `GlassButton.swift` to your Xcode project
3. Import and use in your SwiftUI views

## 📖 Usage

### Basic Implementation

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        GlassButton()
    }
}
```

### Custom Button

```swift
AnimatedButton(text: "Custom Text", cornerRadius: 20) {
    // Your custom action here
    print("Button tapped!")
}
```

### Customization Options

```swift
// Modify button configuration
struct ButtonConfig {
    static let cornerRadius: CGFloat = 200      // Button roundness
    static let strokeWidth: CGFloat = 2         // Border thickness
    static let shadowRadius: CGFloat = 8        // Shadow blur
    static let pressedScale: CGFloat = 0.8      // Press scale effect
    static let animationDuration: Double = 0.5  // Animation timing
}
```

## 🎨 Customization

### Colors
The component includes several customizable color properties:

```swift
extension Color {
    static let buttonFill = Color(red: 125/255, green: 135/255, blue: 140/255).opacity(0.00)
    static let glassyButtonFill = Color.black.opacity(1.0)
    
    static let frostedBackgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.9, green: 0.9, blue: 0.9),
            Color(red: 0.8, green: 0.82, blue: 0.85)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
```

### Gradients
Four different gradient overlays create the glass effect:
- `topbottom`: White highlight from top
- `bottomtop`: White reflection from bottom  
- `leftotop`: Subtle dark shadow from left
- `rightotop`: Subtle dark shadow from right

## 🏗️ Architecture

The project is organized into several key components:

- **`ButtonConfig`**: Central configuration for all button properties
- **`AnimatedButton`**: Reusable button component with glass effects
- **`GlassButton`**: Main view with counting animation logic
- **Gradient Definitions**: Pre-defined gradients for glass effects
- **Color Extensions**: Custom colors and background gradients

## 🔧 Requirements

- iOS 14.0+
- macOS 11.0+
- Xcode 12.0+
- Swift 5.3+

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by modern glass morphism design trends
- Built with SwiftUI's powerful animation system
- Thanks to the SwiftUI community for design inspiration

## 📞 Support

If you have any questions or run into issues, please open an issue on GitHub or reach out via:

- Twitter: [@Vraj247](https://x.com/Vraj247)

---

⭐ If you found this project helpful, please consider giving it a star on GitHub!
