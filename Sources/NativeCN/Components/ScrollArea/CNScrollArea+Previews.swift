import SwiftUI

struct CNScrollArea_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNScrollArea(maxHeight: 160) {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(1...8, id: \.self) { index in
                        HStack(spacing: 8) {
                            CNBadge("\(index)", variant: .secondary)
                            Text("Scrollable activity item")
                                .font(.subheadline)
                        }
                    }
                }
                .padding()
            }
            .frame(width: 280)
            .cnBorder(cornerRadius: 12)
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
