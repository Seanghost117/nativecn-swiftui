import SwiftUI

struct CNSlider_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNSliderPreviewContent()
                .padding()
        }
    }
}

private struct CNSliderPreviewContent: View {
    @State private var volume = 0.72
    @State private var amount = 40.0

    var body: some View {
        VStack(spacing: 18) {
            CNSlider(value: $volume, label: "Volume", showsValue: true)
            CNSlider(value: $amount, in: 0...100, step: 5, label: "Amount", showsValue: true)
        }
    }
}
