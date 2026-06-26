import SwiftUI

struct CNButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                buttonPreviewContent
            }
            .previewDisplayName("Buttons Light")
            .preferredColorScheme(.light)

            CNThemeProvider(.nativeCNDark) {
                buttonPreviewContent
            }
            .previewDisplayName("Buttons Dark")
            .preferredColorScheme(.dark)
        }
    }

    private static var buttonPreviewContent: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                CNPreviewMatrix("Variants", states: [CNPreviewState(name: "Default")]) { _ in
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(CNButton<Text>.Variant.allCases, id: \.self) { variant in
                            CNButton(variant.rawValue.capitalized, variant: variant) {}
                        }
                    }
                }

                CNPreviewMatrix("Sizes", states: [CNPreviewState(name: "Default")]) { _ in
                    HStack {
                        CNButton("Small", size: .sm) {}
                        CNButton("Medium", size: .md) {}
                        CNButton("Large", size: .lg) {}
                        CNButton(variant: .outline, size: .icon) {} label: {
                            Image(systemName: "gearshape")
                        }
                        .accessibilityLabel("Settings")
                    }
                }

                CNPreviewMatrix("States") { state in
                    CNButton(
                        state.name,
                        variant: state.controlState.isInvalid ? .destructive : .primary,
                        isLoading: state.controlState.isLoading,
                        isDisabled: !state.controlState.isEnabled
                    ) {}
                }
            }
            .padding()
        }
    }
}
