import SwiftUI

struct CNButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            VStack(alignment: .leading, spacing: 16) {
                CNButtonGroup {
                    CNButton("Preview", variant: .outline, size: .sm) {}
                    CNButton("Share", variant: .outline, size: .sm) {}
                    CNButton("Publish", size: .sm) {}
                }

                CNButtonGroup(orientation: .vertical) {
                    CNButton("Duplicate", variant: .ghost, size: .sm) {}
                    CNButton("Archive", variant: .ghost, size: .sm) {}
                }
            }
            .padding()
        }
    }
}

