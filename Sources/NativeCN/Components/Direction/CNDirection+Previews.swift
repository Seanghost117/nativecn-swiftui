import SwiftUI

struct CNDirection_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(spacing: 16) {
                CNDirectionProvider(.ltr) {
                    CNItem("Left to right", subtitle: "Leading content stays on the left", systemImage: "arrow.right")
                }

                CNDirectionProvider(.rtl) {
                    CNItem("Right to left", subtitle: "Leading content follows layout direction", systemImage: "arrow.left")
                }
            }
            .padding()
        }
    }
}

