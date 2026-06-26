import SwiftUI

struct CNSeparator_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(spacing: 20) {
                Text("Horizontal")
                CNSeparator()

                HStack {
                    Text("Leading")
                    CNSeparator(.vertical)
                        .frame(height: 32)
                    Text("Trailing")
                }
            }
            .padding()
        }
    }
}
