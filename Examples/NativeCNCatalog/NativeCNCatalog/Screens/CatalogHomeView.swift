import NativeCN
import SwiftUI

struct CatalogHomeView: View {
    @State private var useDarkTheme = false
    @State private var dynamicTypeSize = DynamicTypeSize.large

    var body: some View {
        CNThemeProvider(useDarkTheme ? .nativeCNDark : .nativeCNLight) {
            NavigationStack {
                List {
                    Section("Preview") {
                        Toggle("Dark theme", isOn: $useDarkTheme)

                        Picker("Dynamic Type", selection: $dynamicTypeSize) {
                            Text("Default").tag(DynamicTypeSize.large)
                            Text("XXL").tag(DynamicTypeSize.xxLarge)
                            Text("Accessibility").tag(DynamicTypeSize.accessibility2)
                        }
                    }

                    Section("Start Here") {
                        NavigationLink {
                            CatalogDemoLabPage(useDarkTheme: $useDarkTheme)
                        } label: {
                            Label("Demo Lab", systemImage: "macwindow.badge.plus")
                        }
                    }

                    Section("Components") {
                        NavigationLink("Button") {
                            CatalogButtonPage()
                        }

                        NavigationLink("Badge") {
                            CatalogBadgePage()
                        }

                        NavigationLink("Card") {
                            CatalogCardPage()
                        }

                        NavigationLink("Input & Field") {
                            CatalogInputPage()
                        }

                        NavigationLink("Forms & Controls") {
                            CatalogFormsControlsPage()
                        }

                        NavigationLink("Loading & Media") {
                            CatalogLoadingMediaPage()
                        }

                        NavigationLink("Feedback & Overlays") {
                            CatalogFeedbackOverlaysPage()
                        }

                        NavigationLink("Layout") {
                            CatalogLayoutPage()
                        }

                        NavigationLink("Navigation") {
                            CatalogNavigationPage()
                        }

                        NavigationLink("Data Display") {
                            CatalogDataDisplayPage()
                        }

                        NavigationLink("Content") {
                            CatalogContentPage()
                        }

                        NavigationLink("Interaction") {
                            CatalogInteractionPage()
                        }

                        NavigationLink("Command") {
                            CatalogCommandPage()
                        }

                        NavigationLink("Calendar") {
                            CatalogCalendarPage()
                        }

                        NavigationLink("Chat") {
                            CatalogChatPage()
                        }

                        NavigationLink("MVP Components") {
                            MVPComponentsExampleView()
                        }
                    }

                    Section("Foundation") {
                        NavigationLink("Tokens") {
                            CatalogTokensPage()
                        }

                        NavigationLink("Theme Playground") {
                            CatalogThemePlaygroundPage(useDarkTheme: $useDarkTheme)
                        }
                    }

                    Section("Shell") {
                        ForEach(CatalogPlaceholderPage.allCases) { page in
                            NavigationLink(page.title) {
                                if page == .forms {
                                    CatalogFormsControlsPage()
                                } else if page == .feedback {
                                    CatalogFeedbackOverlaysPage()
                                } else if page == .layout {
                                    CatalogLayoutPage()
                                } else if page == .navigation {
                                    CatalogNavigationPage()
                                } else if page == .examples {
                                    CatalogExampleScreensPage()
                                } else {
                                    CatalogPlaceholderView(title: page.title, systemImage: page.systemImage)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("NativeCN")
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
            .dynamicTypeSize(dynamicTypeSize)
            .preferredColorScheme(useDarkTheme ? .dark : .light)
        }
    }
}

private enum CatalogPlaceholderPage: String, CaseIterable, Identifiable {
    case forms
    case feedback
    case navigation
    case layout
    case accessibility
    case examples

    var id: String { rawValue }

    var title: String {
        switch self {
        case .forms:
            return "Forms"
        case .feedback:
            return "Feedback"
        case .navigation:
            return "Navigation"
        case .layout:
            return "Layout"
        case .accessibility:
            return "Accessibility Playground"
        case .examples:
            return "Example Screens"
        }
    }

    var systemImage: String {
        switch self {
        case .forms:
            return "list.bullet.rectangle"
        case .feedback:
            return "exclamationmark.bubble"
        case .navigation:
            return "sidebar.left"
        case .layout:
            return "rectangle.grid.2x2"
        case .accessibility:
            return "accessibility"
        case .examples:
            return "iphone"
        }
    }
}

struct CatalogPage<Content: View>: View {
    @Environment(\.cnTheme) private var theme

    let title: String
    let subtitle: String
    let content: Content

    init(title: String, subtitle: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: theme.space.x5) {
                VStack(alignment: .leading, spacing: theme.space.x2) {
                    Text(title)
                        .font(theme.typography.title2.font)
                        .foregroundStyle(theme.colors.foreground.color)

                    Text(subtitle)
                        .font(theme.typography.body.font)
                        .foregroundStyle(theme.colors.mutedForeground.color)
                }

                content
            }
            .padding(theme.space.x4)
        }
        .background(theme.colors.background.color)
        .navigationTitle(title)
    }
}

private struct CatalogPlaceholderView: View {
    @Environment(\.cnTheme) private var theme

    let title: String
    let systemImage: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: systemImage)
                .font(.largeTitle)
                .foregroundStyle(.secondary)

            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            Text("This section is reserved for the next component wave and will fill in as the catalog expands.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.colors.background.color)
        .navigationTitle(title)
    }
}

struct CatalogHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogHomeView()
    }
}
