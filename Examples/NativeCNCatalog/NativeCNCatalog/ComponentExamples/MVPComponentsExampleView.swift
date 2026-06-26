import NativeCN
import SwiftUI

struct MVPComponentsExampleView: View {
    @State private var useDarkTheme = false
    @State private var displayName = "Taylor"
    @State private var email = ""
    @State private var query = "NativeCN"

    var body: some View {
        CNThemeProvider(useDarkTheme ? .nativeCNDark : .nativeCNLight) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    CNCard {
                        CNCardHeader {
                            CNCardTitle("Catalog Theme")
                            CNCardDescription("Preview the MVP components in light and dark themes.")
                        }

                        CNCardContent {
                            Toggle("Use dark theme", isOn: $useDarkTheme)
                        }
                    }

                    CNCard {
                        CNCardHeader {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    CNCardTitle("Profile")
                                    CNCardDescription("A simple settings form built from MVP components.")
                                }

                                Spacer()

                                CNBadge("MVP", variant: .secondary)
                            }
                        }

                        CNCardContent {
                            VStack(spacing: 16) {
                                CNField(label: "Display name") {
                                    CNInput("Display name", text: $displayName)
                                }

                                CNField(
                                    label: "Email",
                                    description: "Use your work email.",
                                    error: email.isEmpty ? "Email is required." : nil,
                                    isRequired: true
                                ) {
                                    CNInput("Email", text: $email, keyboardType: .emailAddress)
                                }

                                CNField(label: "Search") {
                                    CNInput("Search", text: $query, leadingIcon: "magnifyingglass")
                                }
                            }
                        }

                        CNCardFooter {
                            CNButton("Cancel", variant: .outline) {}
                            CNButton("Save") {}
                        }
                    }

                    CNPreviewMatrix("Button States") { state in
                        CNButton(
                            state.name,
                            variant: state.controlState.isInvalid ? .destructive : .primary,
                            isLoading: state.controlState.isLoading,
                            isDisabled: !state.controlState.isEnabled
                        ) {}
                    }

                    CNSeparator()
                }
                .padding()
            }
            .background((useDarkTheme ? CNTheme.nativeCNDark : CNTheme.nativeCNLight).colors.background.color)
            .navigationTitle("MVP Components")
        }
    }
}

struct MVPComponentsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MVPComponentsExampleView()
        }
    }
}
