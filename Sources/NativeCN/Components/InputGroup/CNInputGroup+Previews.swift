import SwiftUI

struct CNInputGroup_Previews: PreviewProvider {
    struct Preview: View {
        @State private var domain = "nativecn"
        @State private var amount = "42"

        var body: some View {
            CNThemeProvider {
                VStack(alignment: .leading, spacing: 16) {
                    CNInputGroup("workspace", text: $domain, trailingText: ".app")
                    CNInputGroup("Amount", text: $amount, leadingText: "$")
                }
                .padding()
            }
        }
    }

    static var previews: some View {
        Preview()
    }
}

