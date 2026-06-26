import SwiftUI

struct CNField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                fieldPreviewContent
            }
            .previewDisplayName("Fields Light")

            CNThemeProvider(.nativeCNDark) {
                fieldPreviewContent
            }
            .previewDisplayName("Fields Dark")
            .preferredColorScheme(.dark)
        }
    }

    private static var fieldPreviewContent: some View {
        CNFieldPreviewForm()
            .padding()
    }
}

private struct CNFieldPreviewForm: View {
    @State private var email = ""
    @State private var search = "NativeCN"
    @State private var amount = "49"

    var body: some View {
        VStack(spacing: 20) {
            CNField(label: "Email", description: "Use your work email.", isRequired: true) {
                CNInput("Email", text: $email, keyboardType: .emailAddress)
            }

            CNField(label: "Search", description: "Leading accessory") {
                CNInput("Search", text: $search, leadingIcon: "magnifyingglass")
            }

            CNField(label: "Amount", error: "Amount must be greater than zero.") {
                CNInput("Amount", text: $amount, trailing: {
                    Text("USD")
                })
            }
        }
    }
}
