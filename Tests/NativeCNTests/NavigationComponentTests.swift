import SwiftUI
import XCTest

@testable import NativeCN

final class NavigationComponentTests: XCTestCase {
    func testNavigationOptionValuesUseValueAsIdentifier() {
        let segment = CNSegmentedControlOption("Overview", value: "overview", systemImage: "square.grid.2x2")
        let tab = CNTabItem("Tasks", value: "tasks", systemImage: "checklist")
        let crumb = CNBreadcrumbItem(id: "home", title: "Home", systemImage: "house")
        let sidebar = CNSidebarItem("Inbox", value: "inbox", systemImage: "tray", badge: "4")
        let menu = CNNavigationMenuItem("Active", value: "active", subtitle: "Open work", systemImage: "folder", badge: "2")

        XCTAssertEqual(segment.id, "overview")
        XCTAssertEqual(segment.systemImage, "square.grid.2x2")
        XCTAssertEqual(tab.id, "tasks")
        XCTAssertEqual(tab.title, "Tasks")
        XCTAssertEqual(crumb.id, "home")
        XCTAssertFalse(crumb.isCurrent)
        XCTAssertEqual(sidebar.id, "inbox")
        XCTAssertEqual(sidebar.badge, "4")
        XCTAssertFalse(sidebar.isDisabled)
        XCTAssertEqual(menu.id, "active")
        XCTAssertEqual(menu.subtitle, "Open work")
        XCTAssertEqual(menu.badge, "2")
    }

    func testNavigationComponentsCompileTogetherInNavigationScreen() {
        _ = NavigationSmokeView()
    }
}

private struct NavigationSmokeView: View {
    @State private var tab = "overview"
    @State private var density = "comfortable"
    @State private var sidebar = "overview"
    @State private var menu = "overview"

    var body: some View {
        CNThemeProvider {
            VStack {
                CNBreadcrumb(items: [
                    CNBreadcrumbItem(id: "home", title: "Home", systemImage: "house"),
                    CNBreadcrumbItem(id: "projects", title: "Projects", isCurrent: true),
                ])

                CNTabs(selection: $tab, items: [
                    CNTabItem("Overview", value: "overview"),
                    CNTabItem("Tasks", value: "tasks"),
                ])

                CNSegmentedControl(selection: $density, options: [
                    CNSegmentedControlOption("Compact", value: "compact"),
                    CNSegmentedControlOption("Comfortable", value: "comfortable"),
                ])

                CNNavigationMenu(selection: $menu, groups: [
                    CNNavigationMenuGroup(id: "overview", title: "Overview", value: "overview"),
                    CNNavigationMenuGroup(id: "projects", title: "Projects", items: [
                        CNNavigationMenuItem("Active", value: "active", systemImage: "folder"),
                        CNNavigationMenuItem("Archived", value: "archived", systemImage: "archivebox"),
                    ]),
                ])

                CNSidebar("Workspace", selection: $sidebar, sections: [
                    CNSidebarSection(id: "main", title: "Main", items: [
                        CNSidebarItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
                        CNSidebarItem("Inbox", value: "inbox", systemImage: "tray", badge: "4"),
                    ]),
                ])
            }
        }
    }
}
