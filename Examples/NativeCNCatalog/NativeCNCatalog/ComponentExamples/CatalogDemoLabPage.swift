import NativeCN
import Charts
import SwiftUI

struct CatalogDemoLabPage: View {
    @Environment(\.cnTheme) private var theme

    @Binding var useDarkTheme: Bool

    @State private var selectedTOCSection = DemoLabSection.foundation.id
    @State private var workspaceName = "NativeCN"
    @State private var releaseNotes = "Ship the catalog demo lab with guided coverage."
    @State private var selectedRole: String? = "maintainer"
    @State private var selectedChannel = "public"
    @State private var notificationsEnabled = true
    @State private var packageQuality = 0.82
    @State private var selectedResource = "None"
    @State private var tablePage = 1
    @State private var selectedTab = "overview"
    @State private var selectedSidebar = "overview"
    @State private var selectedDay: Date? = Date()
    @State private var launchStart = Date()
    @State private var launchEnd = Date(timeIntervalSinceNow: 86_400 * 14)
    @State private var toast: CNToast?
    @State private var chatAnchor: AnyHashable? = AnyHashable("demo-final")
    @State private var releaseExpanded = true

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: theme.space.x5) {
                    header(proxy: proxy)
                        .id("top")

                    tableOfContents(proxy: proxy)

                    foundationSection
                        .id(DemoLabSection.foundation.id)

                    controlsSection
                        .id(DemoLabSection.controls.id)

                    feedbackSection
                        .id(DemoLabSection.feedback.id)

                    mediaSection
                        .id(DemoLabSection.media.id)

                    dataSection
                        .id(DemoLabSection.data.id)

                    contentSection
                        .id(DemoLabSection.content.id)

                    workflowSection
                        .id(DemoLabSection.workflow.id)

                    calendarSection
                        .id(DemoLabSection.calendar.id)

                    chatSection
                        .id(DemoLabSection.chat.id)
                }
                .padding(theme.space.x4)
            }
            .background(theme.colors.background.color)
            .navigationTitle("Demo Lab")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        useDarkTheme.toggle()
                    } label: {
                        Label(useDarkTheme ? "Light" : "Dark", systemImage: useDarkTheme ? "sun.max" : "moon")
                    }
                    .accessibilityLabel(useDarkTheme ? "Switch to light theme" : "Switch to dark theme")
                }
            }
        }
        .cnToast($toast)
    }

    private func header(proxy: ScrollViewProxy) -> some View {
        CNPageHeader(
            "NativeCN Demo Lab",
            subtitle: "A guided, jumpable workspace for testing the package as a real app surface."
        ) {
            HStack(spacing: 8) {
                CNButton(variant: .outline, size: .sm) {
                    useDarkTheme.toggle()
                } label: {
                    Label(useDarkTheme ? "Light" : "Dark", systemImage: useDarkTheme ? "sun.max" : "moon")
                }

                CNButton("Contents", variant: .secondary, size: .sm) {
                    withAnimation(.snappy) {
                        proxy.scrollTo("contents", anchor: .top)
                    }
                }
            }
        }
    }

    private func tableOfContents(proxy: ScrollViewProxy) -> some View {
        CNSection("Table of Contents", subtitle: "Jump into a category, use the controls, then return here from any section.") {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 180), spacing: 12)], alignment: .leading, spacing: 12) {
                ForEach(DemoLabSection.allCases) { section in
                    Button {
                        selectedTOCSection = section.id
                        withAnimation(.snappy) {
                            proxy.scrollTo(section.id, anchor: .top)
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 8) {
                                Image(systemName: section.systemImage)
                                    .frame(width: 22, height: 22)
                                    .foregroundStyle(theme.colors.primary.color)

                                Spacer(minLength: 8)

                                CNBadge(section.countLabel, variant: selectedTOCSection == section.id ? .primary : .secondary)
                            }

                            Text(section.title)
                                .font(theme.typography.headline.font)
                                .foregroundStyle(theme.colors.foreground.color)
                                .lineLimit(2)

                            Text(section.subtitle)
                                .font(theme.typography.caption.font)
                                .foregroundStyle(theme.colors.mutedForeground.color)
                                .lineLimit(3)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity, minHeight: 132, alignment: .topLeading)
                        .background(theme.colors.background.color)
                        .clipShape(RoundedRectangle(cornerRadius: theme.radius.md))
                        .cnBorder(
                            color: selectedTOCSection == section.id ? theme.colors.primary : theme.colors.border,
                            cornerRadius: theme.radius.md
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
        }
        .id("contents")
    }

    private var foundationSection: some View {
        CNSection("Foundation", subtitle: "The package assets at a glance: tokens, primitives, registry metadata, and catalog examples.") {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    CNStat("Components", value: "50", detail: "directories", trend: "current") {
                        Image(systemName: "square.grid.2x2")
                            .foregroundStyle(.secondary)
                    }

                    CNStat("Registry", value: "78", detail: "items", trend: "validated") {
                        Image(systemName: "shippingbox")
                            .foregroundStyle(.secondary)
                    }
                }

                CNDescriptionList([
                    CNDescriptionItem(id: "tokens", label: "Tokens", value: "Color, radius, spacing, typography, shadows"),
                    CNDescriptionItem(id: "controls", label: "Controls", value: "Buttons, fields, selects, toggles, sliders"),
                    CNDescriptionItem(id: "surfaces", label: "Surfaces", value: "Cards, sections, overlays, drawers, sheets"),
                    CNDescriptionItem(id: "examples", label: "Examples", value: "Catalog pages, demo lab, product screens"),
                ])

                CNCallout(
                    "How to use this lab",
                    message: "Start from the table of contents, change the theme, resize the window, and interact with each area like a small product workspace.",
                    variant: .info
                )
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var controlsSection: some View {
        CNSection("Controls", subtitle: "Form primitives with real state so users can test keyboard entry, selection, and sizing.") {
            VStack(alignment: .leading, spacing: 16) {
                CNField(label: "Workspace name", description: "Plain text input inside the themed field shell.") {
                    CNInput("Workspace", text: $workspaceName)
                }

                CNField(label: "Release notes", description: "Textarea behavior for longer authoring flows.") {
                    CNTextarea("Describe the release", text: $releaseNotes, minHeight: 96, maxHeight: 160)
                }

                HStack(alignment: .top, spacing: 14) {
                    CNField(label: "Maintainer role") {
                        CNSelect(
                            "Role",
                            selection: $selectedRole,
                            options: [
                                CNSelectOption("Owner", value: "owner"),
                                CNSelectOption("Maintainer", value: "maintainer"),
                                CNSelectOption("Contributor", value: "contributor"),
                            ]
                        )
                    }

                    CNField(label: "Release channel") {
                        CNNativeSelect(
                            "Channel",
                            selection: $selectedChannel,
                            options: [
                                CNSelectOption("Public", value: "public"),
                                CNSelectOption("Beta", value: "beta"),
                                CNSelectOption("Internal", value: "internal"),
                            ]
                        )
                    }
                }

                CNSwitch("Notify watchers", isOn: $notificationsEnabled)
                CNSlider(value: $packageQuality, label: "Package confidence", showsValue: true)

                HStack(spacing: 10) {
                    CNButton("Save draft", size: .sm) {
                        toast = CNToast(title: "Draft saved", message: "Form controls are wired to local state.", variant: .success)
                    }

                    CNButton("Reset", variant: .outline, size: .sm) {
                        workspaceName = "NativeCN"
                        releaseNotes = "Ship the catalog demo lab with guided coverage."
                    }
                }
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var feedbackSection: some View {
        CNSection("Feedback & Overlays", subtitle: "Alerts, inline status, menus, hover help, and toast feedback in one compact strip.") {
            VStack(alignment: .leading, spacing: 14) {
                CNAlert("Ready for review", message: "The demo lab is designed to expose spacing, contrast, and interaction issues quickly.", variant: .success)

                HStack(spacing: 10) {
                    CNButton("Toast", variant: .outline, size: .sm) {
                        toast = CNToast(title: "NativeCN", message: "Toast styling follows the active theme.", variant: .default)
                    }

                    CNButton("Help", variant: .ghost, size: .sm) {}
                        .cnTooltip("Use this page for visual QA across light and dark themes.")

                    CNDropdownMenu("Actions", items: [
                        CNDropdownMenuItem(id: "copy", title: "Copy import", systemImage: "doc.on.doc"),
                        CNDropdownMenuItem(id: "favorite", title: "Favorite", systemImage: "star"),
                        CNDropdownMenuItem(id: "archive", title: "Archive", systemImage: "archivebox"),
                    ]) { item in
                        toast = CNToast(title: "Action selected", message: item.title)
                    }
                }

                CNProgress(value: packageQuality)
                CNSkeleton()
                    .frame(height: 18)
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var mediaSection: some View {
        CNSection("Loading & Media", subtitle: "Avatars, loading placeholders, spinners, and progress states for real app surfaces.") {
            VStack(alignment: .leading, spacing: 18) {
                HStack(alignment: .center, spacing: 14) {
                    CNAvatar(fallback: "NC", size: .sm, accessibilityLabel: "NativeCN")
                    CNAvatar(fallback: "DS", size: .md, accessibilityLabel: "Design Systems")
                    CNAvatar(fallback: "UI", size: .lg, accessibilityLabel: "Interface preview")
                    CNAvatar(size: .xl, accessibilityLabel: "Empty avatar placeholder")

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Avatar states")
                            .font(theme.typography.headline.font)
                            .foregroundStyle(theme.colors.foreground.color)

                        Text("Initials, placeholder fallback, and multiple size tokens.")
                            .font(theme.typography.subheadline.font)
                            .foregroundStyle(theme.colors.mutedForeground.color)
                    }
                }

                CNSeparator()

                VStack(alignment: .leading, spacing: 14) {
                    HStack(spacing: 14) {
                        CNSkeleton(shape: .circle, size: 48, label: "Loading avatar")

                        VStack(alignment: .leading, spacing: 8) {
                            CNSkeleton(width: 180, height: 18, label: "Loading title")
                            CNSkeleton(width: 260, height: 16, label: "Loading subtitle")
                        }
                    }

                    CNSkeleton(width: nil, height: 18, label: "Loading full row")
                    CNSkeleton(width: 220, height: 18, label: "Loading shorter row")
                }

                CNSeparator()

                HStack(alignment: .center, spacing: 18) {
                    HStack(spacing: 12) {
                        CNSpinner(size: 16, label: "Small loading spinner")
                        CNSpinner(size: 24, label: "Medium loading spinner")
                        CNSpinner(size: 34, label: "Large loading spinner")
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Package sync")
                                .font(theme.typography.subheadline.font.weight(.medium))
                            Spacer()
                            Text("\(Int((packageQuality * 100).rounded()))%")
                                .font(theme.typography.caption.font)
                                .foregroundStyle(theme.colors.mutedForeground.color)
                        }

                        CNProgress(value: packageQuality, label: "Package sync progress")
                    }
                }

                CNCallout("Loading composition", message: "Combine skeletons, progress, and spinners to show both indeterminate and determinate loading paths.", variant: .info)
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var dataSection: some View {
        CNSection("Data & Charts", subtitle: "Stats, tokenized chart chrome, resource lists, tables, and paging.") {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12) {
                    CNStat("Adoption", value: "82%", detail: "catalog coverage", trend: "+9%") {
                        Image(systemName: "chart.line.uptrend.xyaxis")
                            .foregroundStyle(.secondary)
                    }

                    CNStat("Open gaps", value: "12", detail: "remaining parity items", trend: "-4") {
                        CNStatusBadge("Improving", variant: .success)
                    }
                }

                CNChartContainer(title: "Component Coverage", subtitle: "Representative category coverage", height: 210) {
                    Chart(chartPoints) { point in
                        BarMark(
                            x: .value("Area", point.area),
                            y: .value("Count", point.count)
                        )
                        .foregroundStyle(CNChartPalette.color(at: point.colorIndex, in: theme).color)
                        .cornerRadius(4)
                    }
                } footer: {
                    CNChartLegend([
                        CNChartSeries(id: "foundation", title: "Foundation", colorIndex: 0, detail: "Tokens and shell"),
                        CNChartSeries(id: "controls", title: "Controls", colorIndex: 1, detail: "Forms and input"),
                        CNChartSeries(id: "data", title: "Data", colorIndex: 2, detail: "Tables and charts"),
                    ])
                }

                CNResourceList([
                    CNResourceItem(id: "components", title: "Components", subtitle: "SwiftUI source assets", metadata: "50 groups", systemImage: "square.grid.2x2", status: "Live", statusVariant: .success),
                    CNResourceItem(id: "registry", title: "Registry", subtitle: "Copy/install metadata", metadata: "78 items", systemImage: "shippingbox", status: "Valid", statusVariant: .success),
                    CNResourceItem(id: "docs", title: "Docs", subtitle: "Usage, QA, and release notes", metadata: "Expanded", systemImage: "doc.text", status: "Review", statusVariant: .warning),
                ]) { item in
                    selectedResource = item.title
                }

                CNDataTable(
                    columns: [
                        CNDataTableColumn(id: "area", title: "Area", minWidth: 140),
                        CNDataTableColumn(id: "elements", title: "Elements", minWidth: 110, alignment: .trailing),
                        CNDataTableColumn(id: "state", title: "State", minWidth: 120),
                    ],
                    rows: [
                        CNDataTableRow(id: "controls", values: ["area": "Controls", "elements": "16", "state": "Interactive"]),
                        CNDataTableRow(id: "feedback", values: ["area": "Feedback", "elements": "12", "state": "Live"]),
                        CNDataTableRow(id: "data", values: ["area": "Data", "elements": "10", "state": "Sampled"]),
                    ]
                ) { row in
                    selectedResource = row.values["area"] ?? row.id
                }
            }
            .padding(16)
        } footer: {
            HStack {
                Text("Selected: \(selectedResource)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                Spacer()

                CNPagination(currentPage: $tablePage, totalPages: 4)
            }
        }
    }

    private var contentSection: some View {
        CNSection("Content", subtitle: "Developer-facing notes, code, keyboard hints, and typography samples.") {
            VStack(alignment: .leading, spacing: 14) {
                CNNote("The demo lab is intentionally stateful so package adopters can test controls instead of only seeing static rows.", title: "Catalog note")

                CNCodeBlock(
                    """
                    import NativeCN

                    CNThemeProvider(.nativeCNLight) {
                        CatalogDemoLabPage(useDarkTheme: .constant(false))
                    }
                    """,
                    language: "swift",
                    title: "Theme-mounted preview"
                )

                HStack(spacing: 8) {
                    CNTypography("Open the command palette", style: .body)
                    CNKeyboardShortcut("Command", "K")
                }
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var workflowSection: some View {
        CNSection("Workflow Shell", subtitle: "Navigation, layout, disclosure, rows, and compact product composition.") {
            VStack(alignment: .leading, spacing: 16) {
                ViewThatFits(in: .horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        demoSidebar
                            .frame(width: 245)

                        sidebarDetailPane
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        demoSidebar
                        sidebarDetailPane
                    }
                }

                CNTabs(selection: $selectedTab, items: [
                    CNTabItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
                    CNTabItem("Issues", value: "issues", systemImage: "exclamationmark.bubble"),
                    CNTabItem("Release", value: "release", systemImage: "shippingbox"),
                ])

                CNListRow("Selected workspace", subtitle: selectedTab.capitalized, action: {
                    toast = CNToast(title: "Row tapped", message: selectedTab.capitalized)
                }) {
                    Image(systemName: "macwindow")
                        .foregroundStyle(.secondary)
                } trailing: {
                    CNBadge("Active", variant: .secondary)
                }

                CNAccordion("Release checklist", subtitle: "Disclosure for grouped QA tasks", systemImage: "checklist", isExpanded: $releaseExpanded) {
                    VStack(alignment: .leading, spacing: 10) {
                        CNCheckbox("Build package", isOn: .constant(true))
                        CNCheckbox("Run registry validation", isOn: .constant(true))
                        CNCheckbox("Review dark theme", isOn: $notificationsEnabled)
                    }
                }

                CNEmptyState("No blockers", message: "Issues and regressions will appear here during catalog QA.", systemImage: "checkmark.seal") {
                    CNButton("Add note", size: .sm) {
                        toast = CNToast(title: "Note", message: "Empty-state actions are interactive.")
                    }
                }
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var demoSidebar: some View {
        CNSidebar("Workspace", selection: $selectedSidebar, sections: [
            CNSidebarSection(id: "main", title: "Main", items: [
                CNSidebarItem("Overview", value: "overview", systemImage: "square.grid.2x2"),
                CNSidebarItem("Components", value: "components", systemImage: "square.stack.3d.up", badge: "50"),
                CNSidebarItem("Registry", value: "registry", systemImage: "shippingbox", badge: "78"),
            ]),
            CNSidebarSection(id: "review", title: "Review", items: [
                CNSidebarItem("QA Matrix", value: "qa", systemImage: "checkmark.seal"),
                CNSidebarItem("Releases", value: "releases", systemImage: "tag"),
            ]),
        ])
    }

    private var sidebarDetailPane: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: sidebarIcon)
                    .foregroundStyle(theme.colors.primary.color)
                    .frame(width: 22)

                VStack(alignment: .leading, spacing: 2) {
                    Text(sidebarTitle)
                        .font(theme.typography.headline.font)
                        .foregroundStyle(theme.colors.foreground.color)

                    Text("Selected sidebar value: \(selectedSidebar)")
                        .font(theme.typography.caption.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }

                Spacer()

                CNBadge("Live", variant: .secondary)
            }

            CNSeparator()

            Text(sidebarDetail)
                .font(theme.typography.subheadline.font)
                .foregroundStyle(theme.colors.mutedForeground.color)
                .fixedSize(horizontal: false, vertical: true)

            CNDescriptionList([
                CNDescriptionItem(id: "surface", label: "Surface", value: sidebarTitle),
                CNDescriptionItem(id: "pattern", label: "Pattern", value: "Sidebar + detail pane"),
                CNDescriptionItem(id: "state", label: "State", value: selectedSidebar),
            ])
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(theme.colors.background.color)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.lg))
        .cnBorder(color: theme.colors.border, cornerRadius: theme.radius.lg)
    }

    private var calendarSection: some View {
        CNSection("Calendar", subtitle: "Date selection and range planning in a token-framed schedule surface.") {
            VStack(alignment: .leading, spacing: 16) {
                CNCalendarMonth(selection: $selectedDay)

                if let selectedDay {
                    CNNote(selectedDay.formatted(date: .complete, time: .omitted), title: "Selected day")
                }

                CNDateRangePicker(startDate: $launchStart, endDate: $launchEnd)
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var chatSection: some View {
        CNSection("Chat", subtitle: "Transcript components embedded beside the rest of the product surface.") {
            VStack(alignment: .leading, spacing: 14) {
                CNButton("Scroll latest", variant: .outline, size: .sm) {
                    chatAnchor = AnyHashable("demo-final")
                }

                CNMessageScroller(anchorID: chatAnchor, minHeight: 360) {
                    CNMarker("Demo", variant: .date)

                    CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:41 AM", avatarFallback: "NC") {
                        Text("Use this lab to inspect controls, data, docs, calendar, and chat in one pass.")
                    }

                    CNMessage(role: .user, author: "You", timestamp: "9:42 AM", status: .read, avatarFallback: "YO") {
                        Text("Great. I want a user to feel the whole package quickly.")
                    }

                    CNMarker("Registry", message: "78 items validated", variant: .tool)

                    CNMessage(role: .assistant, author: "NativeCN", timestamp: "9:43 AM", status: .sent, avatarFallback: "NC") {
                        Text("The demo lab now acts as the first-stop showcase and QA bench.")
                    }
                    .id("demo-final")
                }
            }
            .padding(16)
        } footer: {
            backToContents
        }
    }

    private var backToContents: some View {
        HStack {
            Spacer()
            Text("Use the table of contents at the top to jump between categories.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private var chartPoints: [DemoChartPoint] {
        [
            DemoChartPoint(id: "foundation", area: "Foundation", count: 9, colorIndex: 0),
            DemoChartPoint(id: "controls", area: "Controls", count: 16, colorIndex: 1),
            DemoChartPoint(id: "feedback", area: "Feedback", count: 12, colorIndex: 2),
            DemoChartPoint(id: "media", area: "Media", count: 8, colorIndex: 3),
            DemoChartPoint(id: "data", area: "Data", count: 10, colorIndex: 4),
            DemoChartPoint(id: "chat", area: "Chat", count: 5, colorIndex: 0),
        ]
    }

    private var sidebarTitle: String {
        switch selectedSidebar {
        case "components":
            return "Components"
        case "registry":
            return "Registry"
        case "qa":
            return "QA Matrix"
        case "releases":
            return "Releases"
        default:
            return "Overview"
        }
    }

    private var sidebarIcon: String {
        switch selectedSidebar {
        case "components":
            return "square.stack.3d.up"
        case "registry":
            return "shippingbox"
        case "qa":
            return "checkmark.seal"
        case "releases":
            return "tag"
        default:
            return "square.grid.2x2"
        }
    }

    private var sidebarDetail: String {
        switch selectedSidebar {
        case "components":
            return "Browse the current SwiftUI component families and confirm they behave inside real layout constraints."
        case "registry":
            return "Review source ownership metadata, dependency coverage, and install-oriented package details."
        case "qa":
            return "Use the visual matrix to review theme, Dynamic Type, compact width, and interaction behavior."
        case "releases":
            return "Check notes, tags, and release readiness before publishing the next public build."
        default:
            return "Start with the main package status before jumping into specific catalog categories."
        }
    }
}

private enum DemoLabSection: String, CaseIterable, Identifiable {
    case foundation
    case controls
    case feedback
    case media
    case data
    case content
    case workflow
    case calendar
    case chat

    var id: String { rawValue }

    var title: String {
        switch self {
        case .foundation:
            return "Foundation"
        case .controls:
            return "Controls"
        case .feedback:
            return "Feedback"
        case .media:
            return "Loading & Media"
        case .data:
            return "Data & Charts"
        case .content:
            return "Content"
        case .workflow:
            return "Workflow Shell"
        case .calendar:
            return "Calendar"
        case .chat:
            return "Chat"
        }
    }

    var subtitle: String {
        switch self {
        case .foundation:
            return "Tokens, registry, and package assets."
        case .controls:
            return "Inputs, selects, toggles, and sliders."
        case .feedback:
            return "Alerts, menus, progress, and toasts."
        case .media:
            return "Avatars, spinners, skeletons, and progress."
        case .data:
            return "Stats, charts, resources, and tables."
        case .content:
            return "Notes, code blocks, and typography."
        case .workflow:
            return "Navigation, rows, disclosure, and states."
        case .calendar:
            return "Month grid and date ranges."
        case .chat:
            return "Messages, markers, and transcript scroll."
        }
    }

    var systemImage: String {
        switch self {
        case .foundation:
            return "paintpalette"
        case .controls:
            return "slider.horizontal.3"
        case .feedback:
            return "exclamationmark.bubble"
        case .media:
            return "person.crop.circle.badge.clock"
        case .data:
            return "chart.bar"
        case .content:
            return "doc.text"
        case .workflow:
            return "rectangle.3.group"
        case .calendar:
            return "calendar"
        case .chat:
            return "bubble.left.and.bubble.right"
        }
    }

    var countLabel: String {
        switch self {
        case .foundation:
            return "4 groups"
        case .controls:
            return "8 demos"
        case .feedback:
            return "6 demos"
        case .media:
            return "8 demos"
        case .data:
            return "5 demos"
        case .content:
            return "4 demos"
        case .workflow:
            return "5 demos"
        case .calendar:
            return "3 demos"
        case .chat:
            return "4 demos"
        }
    }
}

private struct DemoChartPoint: Identifiable {
    var id: String
    var area: String
    var count: Double
    var colorIndex: Int
}
