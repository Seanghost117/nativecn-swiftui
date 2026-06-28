import SwiftUI

struct CNChat_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNMessageScroller(minHeight: 420) {
                CNMarker("Today", variant: .date)

                CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:41 AM", avatarFallback: "NC") {
                    Text("I can help wire up the chat components and keep the APIs SwiftUI-native.")
                }

                CNMessage(
                    role: .user,
                    author: "You",
                    timestamp: "9:42 AM",
                    status: .read,
                    avatarFallback: "YO",
                    attachments: [
                        CNAttachment(id: "brief", title: "chat-brief.md", subtitle: "Markdown", metadata: "12 KB")
                    ]
                ) {
                    Text("Let's make the chat slice feel polished.")
                }

                CNMarker("Tool finished", message: "Registry metadata generated", variant: .tool)

                CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:43 AM", status: .streaming, avatarFallback: "NC") {
                    Text("Working through docs, tests, catalog examples, and the public registry.")
                }
            }
            .padding()
        }
    }
}

