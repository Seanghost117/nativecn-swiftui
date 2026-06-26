import SwiftUI

struct CNTooltip_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            HStack(spacing: 12) {
                CNButton("Save", variant: .outline) {}
                    .cnTooltip("Saves the current draft.")

                CNButton("Deploy", variant: .outline) {}
                    .cnTooltip {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Deploy")
                                .font(.headline)
                            Text("Publishes the selected environment.")
                        }
                    }
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
