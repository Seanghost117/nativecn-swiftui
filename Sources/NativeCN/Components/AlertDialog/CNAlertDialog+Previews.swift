import SwiftUI

struct CNAlertDialog_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNAlertDialog(
                title: "Delete project?",
                message: "This action cannot be undone.",
                actionTitle: "Delete",
                role: .destructive
            ) {} onAction: {}
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
