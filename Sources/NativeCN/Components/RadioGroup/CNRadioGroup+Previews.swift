import SwiftUI

struct CNRadioGroup_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNRadioGroupPreviewContent()
                .padding()
        }
    }
}

private struct CNRadioGroupPreviewContent: View {
    @State private var plan = "pro"

    var body: some View {
        CNRadioGroup(
            selection: $plan,
            options: [
                CNRadioOption("Free", value: "free", description: "Personal experiments"),
                CNRadioOption("Pro", value: "pro", description: "Production apps"),
                CNRadioOption("Team", value: "team", description: "Shared workspaces"),
            ]
        )
    }
}
