import SwiftUI

struct CNInputOTP_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNInputOTPPreviewContent()
                .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

private struct CNInputOTPPreviewContent: View {
    @State private var code = "123"

    var body: some View {
        CNInputOTP(text: $code, length: 6, groupSize: 3)
    }
}
