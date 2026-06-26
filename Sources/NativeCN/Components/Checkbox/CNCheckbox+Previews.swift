import SwiftUI

struct CNCheckbox_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNCheckboxPreviewContent()
                .padding()
        }
    }
}

private struct CNCheckboxPreviewContent: View {
    @State private var accepted = true

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            CNCheckbox("Accept terms", isOn: $accepted)
            CNCheckbox("Disabled", isOn: .constant(false), isDisabled: true)
        }
    }
}
