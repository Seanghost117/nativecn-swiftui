import SwiftUI
import XCTest

@testable import NativeCN

final class FeedbackOverlayTests: XCTestCase {
    func testAlertVariantsExposeExpectedSymbols() {
        XCTAssertEqual(CNAlert<EmptyView>.Variant.allCases, [.default, .success, .warning, .destructive])
        XCTAssertEqual(CNAlert<EmptyView>.Variant.default.defaultSystemImage, "info.circle")
        XCTAssertEqual(CNAlert<EmptyView>.Variant.success.defaultSystemImage, "checkmark.circle")
        XCTAssertEqual(CNAlert<EmptyView>.Variant.warning.defaultSystemImage, "exclamationmark.triangle")
        XCTAssertEqual(CNAlert<EmptyView>.Variant.destructive.defaultSystemImage, "xmark.octagon")
    }

    func testAlertVariantStylesUseThemeTokens() {
        let theme = CNTheme.nativeCNLight
        let destructive = CNAlert<EmptyView>.Variant.destructive.style(in: theme)

        XCTAssertEqual(destructive.background, theme.colors.background)
        XCTAssertEqual(destructive.foreground, theme.colors.destructive)
        XCTAssertEqual(destructive.border, theme.colors.destructive)
    }

    func testToastDefaultsAndIdentityAreStable() {
        let id = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!
        let toast = CNToast(id: id, title: "Saved")

        XCTAssertEqual(toast.id, id)
        XCTAssertEqual(toast.title, "Saved")
        XCTAssertNil(toast.message)
        XCTAssertEqual(toast.variant, .default)
        XCTAssertEqual(toast.placement, .bottom)
    }

    func testDropdownMenuItemUsesProvidedIdentifier() {
        let item = CNDropdownMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true)

        XCTAssertEqual(item.id, "delete")
        XCTAssertEqual(item.title, "Delete")
        XCTAssertEqual(item.systemImage, "trash")
        XCTAssertTrue(item.isDestructive)
    }

    func testMenubarItemUsesProvidedMetadata() {
        let item = CNMenubarItem(id: "new", title: "New", systemImage: "plus", shortcut: "Command N")
        let menu = CNMenubarMenu(id: "file", title: "File", items: [item])

        XCTAssertEqual(item.id, "new")
        XCTAssertEqual(item.shortcut, "Command N")
        XCTAssertEqual(menu.id, "file")
        XCTAssertEqual(menu.items, [item])
    }

    func testAlertDialogRolesMapToButtonVariants() {
        XCTAssertEqual(CNAlertDialogRole.allCases, [.default, .destructive])
        XCTAssertEqual(CNAlertDialogRole.default.buttonVariant, .primary)
        XCTAssertEqual(CNAlertDialogRole.destructive.buttonVariant, .destructive)
        XCTAssertNil(CNAlertDialogRole.default.buttonRole)
        XCTAssertEqual(CNAlertDialogRole.destructive.buttonRole, .destructive)
    }

    func testDrawerPresenterNormalizesLengthAndClassifiesEdges() {
        XCTAssertEqual(CNDrawerPresenter<EmptyView, EmptyView>.normalizedLength(420), 420)
        XCTAssertEqual(CNDrawerPresenter<EmptyView, EmptyView>.normalizedLength(0), 360)
        XCTAssertEqual(CNDrawerPresenter<EmptyView, EmptyView>.normalizedLength(.infinity), 360)
        XCTAssertTrue(CNDrawerPresenter<EmptyView, EmptyView>.isSideEdge(.leading))
        XCTAssertTrue(CNDrawerPresenter<EmptyView, EmptyView>.isSideEdge(.trailing))
        XCTAssertFalse(CNDrawerPresenter<EmptyView, EmptyView>.isSideEdge(.top))
        XCTAssertFalse(CNDrawerPresenter<EmptyView, EmptyView>.isSideEdge(.bottom))
    }

    func testFeedbackOverlayComponentsCompileTogetherInOverlayScreen() {
        _ = FeedbackOverlaySmokeView()
    }
}

private struct FeedbackOverlaySmokeView: View {
    @State private var showsDialog = false
    @State private var showsAlertDialog = false
    @State private var showsDrawer = false
    @State private var showsSheet = false
    @State private var showsPopover = false
    @State private var toast: CNToast?

    var body: some View {
        CNThemeProvider {
            VStack {
                CNAlert("Update available", message: "A new version is ready.", variant: .default)
                CNToastView(CNToast(title: "Saved", message: "Settings were updated.", variant: .success))

                HStack {
                    CNButton("Dialog") {
                        showsDialog = true
                    }

                    CNButton("Alert Dialog", variant: .outline) {
                        showsAlertDialog = true
                    }

                    CNButton("Sheet", variant: .outline) {
                        showsSheet = true
                    }

                    CNButton("Drawer", variant: .outline) {
                        showsDrawer = true
                    }

                    CNButton("Popover", variant: .ghost) {
                        showsPopover = true
                    }
                    .cnPopover(isPresented: $showsPopover) {
                        Text("Popover content")
                    }

                    CNButton("Hover card", variant: .outline) {}
                        .cnHoverCard {
                            Text("Hover card content")
                        }

                    CNButton("Tooltip", variant: .outline) {}
                        .cnTooltip("Tooltip content")

                    CNDropdownMenu("Actions", items: [
                        CNDropdownMenuItem(id: "archive", title: "Archive", systemImage: "archivebox"),
                        CNDropdownMenuItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                    ]) { item in
                        toast = CNToast(title: "Selected", message: item.title)
                    }

                    CNMenubar(menus: [
                        CNMenubarMenu(id: "file", title: "File", items: [
                            CNMenubarItem(id: "new", title: "New", systemImage: "plus", shortcut: "Command N"),
                            CNMenubarItem(id: "delete", title: "Delete", systemImage: "trash", isDestructive: true),
                        ]),
                    ]) { item in
                        toast = CNToast(title: "Command", message: item.title)
                    }
                }
            }
            .cnToast($toast)
            .cnAlertDialog(
                isPresented: $showsAlertDialog,
                title: "Delete project?",
                message: "This cannot be undone.",
                actionTitle: "Delete"
            ) {
                toast = CNToast(title: "Deleted")
            }
            .cnDrawer(isPresented: $showsDrawer, title: "Inspector") {
                CNButton("Close", variant: .outline) {
                    showsDrawer = false
                }
            }
            .cnDialog(isPresented: $showsDialog) {
                CNDialog(title: "Discard changes?", message: "This action cannot be undone.") {
                    CNButton("Cancel", variant: .outline) {
                        showsDialog = false
                    }
                    CNButton("Discard", variant: .destructive) {
                        showsDialog = false
                    }
                }
            }
            .cnSheet(isPresented: $showsSheet, title: "Sheet", message: "Focused task content.") {
                CNAlert("Sheet content", message: "Use sheets for focused flows.")
            }
        }
    }
}
