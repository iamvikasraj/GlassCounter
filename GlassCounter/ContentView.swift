import SwiftUI

// MARK: - Button Configuration
struct ButtonConfig {
    static let cornerRadius: CGFloat = 200
    static let strokeWidth: CGFloat = 2
    static let shadowRadius: CGFloat = 8
    static let blurRadius: CGFloat = 8
    static let pressedScale: CGFloat = 0.8
    static let animationDuration: Double = 0.5
}

// MARK: - Stroke Gradients
let topbottom = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.white.opacity(0.9), location: 0.0),
        .init(color: Color.white.opacity(0.1), location: 0.4)
    ]),
    startPoint: .top,
    endPoint: .bottom
)

let bottomtop = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.white.opacity(0.7), location: 0.0),
        .init(color: Color.white.opacity(0.0), location: 0.3)
    ]),
    startPoint: .bottom,
    endPoint: .top
)

let leftotop = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.black.opacity(0.08), location: 0.0),
        .init(color: Color.black.opacity(0.0), location: 0.3)
    ]),
    startPoint: .leading,
    endPoint: .topTrailing
)

let rightotop = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color.black.opacity(0.12), location: 0.0),
        .init(color: Color.black.opacity(0.0), location: 0.25)
    ]),
    startPoint: .trailing,
    endPoint: .topLeading
)

// MARK: - Custom Colors
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

// MARK: - AnimatedButton
struct AnimatedButton: View {
    let text: String
    let cornerRadius: CGFloat
    let action: () -> Void

    @State private var isPressed = false

    init(text: String, cornerRadius: CGFloat = ButtonConfig.cornerRadius, action: @escaping () -> Void = {}) {
        self.text = text
        self.cornerRadius = cornerRadius
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(text)
                    .font(.system(size: 16, weight: .regular, design: .monospaced))
                    .foregroundColor(Color.glassyButtonFill)
                    .shadow(color: .black.opacity(0.1), radius: 1, y: 1)
                    .contentTransition(.numericText(countsDown: false))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: text)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.buttonFill)
                    .background(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.buttonFill)
                            .blur(radius: ButtonConfig.blurRadius * 0.75)
                    )
                    .overlay(strokeOverlay)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
        .contentShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(color: .black.opacity(isPressed ? 0.1 : 0.25), radius: isPressed ? 4 : ButtonConfig.shadowRadius, y: isPressed ? 8 : 12)
        .scaleEffect(isPressed ? ButtonConfig.pressedScale : 1)
        .animation(.spring(duration: ButtonConfig.animationDuration), value: isPressed)
        .onPressGesture(
            pressing: { pressing in isPressed = pressing },
            perform: {}
        )
    }

    // MARK: - Stroke Overlay
    var strokeOverlay: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(leftotop, lineWidth: ButtonConfig.strokeWidth)
                .blendMode(.darken)

            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(rightotop, lineWidth: ButtonConfig.strokeWidth)
                .blendMode(.darken)

            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(bottomtop, lineWidth: ButtonConfig.strokeWidth)
                .blendMode(.overlay)

            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(topbottom, lineWidth: ButtonConfig.strokeWidth)
        }
    }
}

// MARK: - Press Gesture Extension
extension View {
    func onPressGesture(pressing: @escaping (Bool) -> Void, perform: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in pressing(true) }
                .onEnded { _ in
                    pressing(false)
                    perform()
                }
        )
    }
}

// MARK: - Main View
struct GlassButton: View {
    @State private var buttonLabel = "Wanna Count?"
    @State private var progress: Int = 0
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 40) {
            AnimatedButton(text: buttonLabel) {
                guard !isAnimating else { return }
                isAnimating = true
                progress = 0
                animateProgress()
            }
            .buttonStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.frostedBackgroundGradient)
    }

    private func animateProgress() {
        Timer.scheduledTimer(withTimeInterval: 0.10, repeats: true) { timer in
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                progress += 1
                buttonLabel = String(format: "%02d", progress)
            }

            if progress >= 100 {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation(.spring()) {
                        buttonLabel = "Yayyyyyy!!!"
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.spring()) {
                        buttonLabel = "Once Again?"
                        isAnimating = false
                    }
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    GlassButton()
}
