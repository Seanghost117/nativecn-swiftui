import NativeCN
import SwiftUI

struct CatalogChatPage: View {
    @State private var anchorID: AnyHashable? = AnyHashable("final")

    var body: some View {
        CatalogPage(
            title: "Chat",
            subtitle: "Message rows, bubbles, attachments, markers, and transcript scrolling."
        ) {
            CNPageHeader("Conversation", subtitle: "A chat-style workflow composed from NativeCN chat components.") {
                CNButton("Scroll latest", variant: .outline, size: .sm) {
                    anchorID = AnyHashable("final")
                }
            }

            CNMessageScroller(anchorID: anchorID, minHeight: 520) {
                CNMarker("Today", variant: .date)

                CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:41 AM", avatarFallback: "NC") {
                    Text("I can help turn the latest shadcn chat surface into SwiftUI-native components.")
                }
                .id("intro")

                CNMessage(
                    role: .user,
                    author: "You",
                    timestamp: "9:42 AM",
                    status: .read,
                    avatarFallback: "YO",
                    attachments: [
                        CNAttachment(id: "brief", title: "chat-slice-notes.md", subtitle: "Markdown brief", metadata: "12 KB"),
                    ]
                ) {
                    Text("Let's build the chat component slice and keep it polished.")
                }

                CNMarker("Tool finished", message: "Registry metadata generated", variant: .tool)

                CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:43 AM", status: .streaming, avatarFallback: "NC") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("The first pass includes:")
                        Text("Message Scroller, Message, Bubble, Attachment, and Marker.")
                    }
                }

                CNMessage(role: .system, author: "System", timestamp: "9:44 AM", status: .delivered, avatarFallback: "SY") {
                    Text("Transcript state remains app-owned; NativeCN provides the presentation and scroll container.")
                }

                CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:45 AM", status: .sent, avatarFallback: "NC") {
                    Text("Docs, catalog examples, registry items, and tests are ready for review.")
                }
                .id("final")
            }

            CNSection("Bubbles", subtitle: "Role-aware colors and alignment.") {
                VStack(alignment: .leading, spacing: 12) {
                    CNBubble(role: .assistant) {
                        Text("Assistant bubble")
                    }

                    CNBubble(role: .user) {
                        Text("User bubble")
                    }

                    CNBubble(role: .tool) {
                        Text("Tool result bubble")
                    }
                }
                .padding(16)
            }

            CNSection("Markers", subtitle: "Timeline, tool, status, and error boundaries.") {
                VStack(spacing: 12) {
                    CNMarker("Today", variant: .date)
                    CNMarker("Delivered", message: "5 messages", variant: .status)
                    CNMarker("Tool call", message: "Search completed", variant: .tool)
                    CNMarker("Send failed", message: "Retry from the message menu.", variant: .error)
                }
                .padding(16)
            }
        }
    }
}

