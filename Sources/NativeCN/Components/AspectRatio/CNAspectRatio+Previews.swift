import SwiftUI

struct CNAspectRatio_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNAspectRatio(16.0 / 9.0) {
                ZStack {
                    Rectangle()
                        .fill(.quaternary)

                    VStack(spacing: 8) {
                        Image(systemName: "photo")
                            .font(.title2)
                        Text("16:9")
                            .font(.headline)
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .frame(width: 320)
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
