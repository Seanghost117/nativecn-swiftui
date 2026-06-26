import SwiftUI

struct CNNavigation_Previews: PreviewProvider {
    static var previews: some View {
        CNThemeProvider {
            CNNavigationPreviewContent()
                .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

private struct CNNavigationPreviewContent: View {
    @State private var tab = "overview"
    @State private var density = "comfortable"
    @State private var sidebar = "overview"
    @State private var menu = "overview"

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CNBreadcrumb(items: [
                CNBreadcrumbItem(id: "home", title: "Home", systemImage: "house"),
                CNBreadcrumbItem(id: "projects", title: "Projects"),
                CNBreadcrumbItem(id: "nativecn", title: "NativeCN", isCurrent: true),
            ])

            CNTabs(selection: $tab, items: [
                CNTabItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
                CNTabItem("Tasks", value: "tasks", systemImage: "checklist"),
                CNTabItem("Files", value: "files", systemImage: "folder"),
            ])

            CNSegmentedControl(selection: $density, options: [
                CNSegmentedControlOption("Compact", value: "compact"),
                CNSegmentedControlOption("Comfortable", value: "comfortable"),
                CNSegmentedControlOption("Spacious", value: "spacious"),
            ])

            CNSidebar("Workspace", selection: $sidebar, sections: [
                CNSidebarSection(id: "main", title: "Main", items: [
                    CNSidebarItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
                    CNSidebarItem("Inbox", value: "inbox", systemImage: "tray", badge: "4"),
                    CNSidebarItem("Settings", value: "settings", systemImage: "gearshape"),
                ]),
            ])
            .frame(width: 260)

            CNNavigationMenu(selection: $menu, groups: [
                CNNavigationMenuGroup(id: "overview", title: "Overview", systemImage: "square.grid.2x2", value: "overview"),
                CNNavigationMenuGroup(id: "projects", title: "Projects", systemImage: "folder", items: [
                    CNNavigationMenuItem("Active", value: "active", systemImage: "folder"),
                    CNNavigationMenuItem("Archived", value: "archived", systemImage: "archivebox"),
                ]),
            ])
        }
    }
}
