import SwiftUI

struct CNSwitch_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNSwitchPreviewContent()
                .padding()
        }
    }
}

private struct CNSwitchPreviewContent: View {
    @State private var enabled = true

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            CNSwitch("Notifications", isOn: $enabled)
            CNSwitch("Disabled", isOn: .constant(false), isDisabled: true)
        }
    }
}
