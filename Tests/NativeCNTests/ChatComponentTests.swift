import SwiftUI
import XCTest

@testable import NativeCN

final class ChatComponentTests: XCTestCase {
    func testChatEnumsExposeExpectedCases() {
        XCTAssertEqual(CNMessageRole.allCases, [.user, .assistant, .system, .tool])
        XCTAssertEqual(CNMessageStatus.allCases, [.streaming, .sent, .delivered, .read, .failed])
        XCTAssertEqual(CNMarker.Variant.allCases, [.date, .status, .tool, .error])
    }

    func testAttachmentMetadataIsStable() {
        let attachment = CNAttachment(
            id: "brief",
            title: "chat-brief.md",
            subtitle: "Markdown",
            metadata: "12 KB",
            systemImage: "doc.text"
        )

        XCTAssertEqual(attachment.id, "brief")
        XCTAssertEqual(attachment.title, "chat-brief.md")
        XCTAssertEqual(attachment.subtitle, "Markdown")
        XCTAssertEqual(attachment.metadata, "12 KB")
        XCTAssertEqual(attachment.systemImage, "doc.text")
    }

    func testBubbleWidthNormalizationBoundsValues() {
        XCTAssertEqual(CNBubble<Text>.normalizedMaxWidthFraction(0.1), 0.42)
        XCTAssertEqual(CNBubble<Text>.normalizedMaxWidthFraction(0.78), 0.78)
        XCTAssertEqual(CNBubble<Text>.normalizedMaxWidthFraction(2), 1)
    }

    func testMessageStatusLabelsAreReadable() {
        XCTAssertEqual(CNMessageStatus.streaming.label, "Streaming")
        XCTAssertEqual(CNMessageStatus.sent.label, "Sent")
        XCTAssertEqual(CNMessageStatus.delivered.label, "Delivered")
        XCTAssertEqual(CNMessageStatus.read.label, "Read")
        XCTAssertEqual(CNMessageStatus.failed.label, "Failed")
    }

    func testChatComponentsCompileTogetherInTranscript() {
        _ = ChatSmokeView()
    }
}

private struct ChatSmokeView: View {
    @State private var anchorID: AnyHashable? = AnyHashable("latest")

    var body: some View {
        CNThemeProvider {
            CNMessageScroller(anchorID: anchorID, minHeight: 320) {
                CNMarker("Today", variant: .date)

                CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:41 AM", avatarFallback: "NC") {
                    Text("Assistant message")
                }

                CNMessage(
                    role: .user,
                    author: "You",
                    timestamp: "9:42 AM",
                    status: .read,
                    avatarFallback: "YO",
                    attachments: [
                        CNAttachment(id: "brief", title: "chat-brief.md", subtitle: "Markdown", metadata: "12 KB"),
                    ]
                ) {
                    Text("User message")
                }

                CNBubble(role: .tool) {
                    Text("Tool result")
                }

                CNMarker("Tool finished", message: "Search complete", variant: .tool)
                    .id("latest")
            }
        }
    }
}

