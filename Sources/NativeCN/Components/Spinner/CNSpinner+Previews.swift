import SwiftUI

struct CNSpinner_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CNThemeProvider(.nativeCNLight) {
                HStack(spacing: 18) {
                    CNSpinner(size: 16)
                    CNSpinner(size: 24)
                    CNSpinner(size: 36)
                }
                .padding()
            }
            .previewDisplayName("Spinners Light")

            CNThemeProvider(.nativeCNDark) {
                HStack(spacing: 18) {
                    CNSpinner(size: 16)
                    CNSpinner(size: 24)
                    CNSpinner(size: 36)
                }
                .padding()
            }
            .previewDisplayName("Spinners Dark")
            .preferredColorScheme(.dark)
        }
    }
}
