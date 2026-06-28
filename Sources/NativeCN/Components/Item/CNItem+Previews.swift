import SwiftUI

struct CNItem_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(spacing: 12) {
                CNItem("Billing", subtitle: "Manage invoices and payment methods", systemImage: "creditcard")

                CNItem("Notifications", subtitle: "Workspace and deployment updates") {
                    Image(systemName: "bell")
                } trailing: {
                    CNStatusBadge("On", variant: .success)
                }
            }
            .padding()
        }
    }
}

