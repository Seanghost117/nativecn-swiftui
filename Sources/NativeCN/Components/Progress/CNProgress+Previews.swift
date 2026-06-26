import SwiftUI

struct CNProgress_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(alignment: .leading, spacing: 16) {
                CNProgress(value: 0.25, label: "Quarter complete")
                CNProgress(value: 0.7, label: "Upload progress")
                CNProgress(value: 1.2, label: "Clamped progress")
            }
            .padding()
        }
    }
}
