import NativeCN
import SwiftUI

struct CatalogExampleScreensPage: View {
    @State private var email = ""
    @State private var name = "Taylor Lee"

    var body: some View {
        CatalogPage(
            title: "Example Screens",
            subtitle: "Small product surfaces built only from the current MVP component set."
        ) {
            loginCard
            settingsCard
            profileCard
            billingCard
            dashboardCard
        }
    }

    private var loginCard: some View {
        CNCard {
            CNCardHeader {
                CNCardTitle("Login")
                CNCardDescription("A compact auth form using Field and Input.")
            }

            CNCardContent {
                CNField(label: "Email") {
                    CNInput("you@example.com", text: $email, keyboardType: .emailAddress)
                }
            }

            CNCardFooter {
                CNButton("Continue") {}
            }
        }
    }

    private var settingsCard: some View {
        CNCard {
            CNCardHeader {
                CNCardTitle("Settings")
                CNCardDescription("Grouped controls and status metadata.")
            }

            CNCardContent {
                HStack {
                    Text("Sync")
                    Spacer()
                    CNBadge("Enabled", variant: .secondary)
                }
            }
        }
    }

    private var profileCard: some View {
        CNCard {
            CNCardHeader {
                CNCardTitle("Profile")
                CNCardDescription("Simple editable profile details.")
            }

            CNCardContent {
                CNField(label: "Display name") {
                    CNInput("Display name", text: $name)
                }
            }
        }
    }

    private var billingCard: some View {
        CNCard {
            CNCardHeader {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        CNCardTitle("Billing")
                        CNCardDescription("Subscription state with actions.")
                    }

                    Spacer()
                    CNBadge("Pro", variant: .primary)
                }
            }

            CNCardFooter {
                CNButton("Manage", variant: .outline) {}
            }
        }
    }

    private var dashboardCard: some View {
        CNCard {
            CNCardHeader {
                CNCardTitle("Dashboard")
                CNCardDescription("A metric card using current primitives.")
            }

            CNCardContent {
                HStack {
                    metric("Revenue", "$12.4k")
                    CNSeparator(.vertical)
                        .frame(height: 44)
                    metric("Users", "1,248")
                }
            }
        }
    }

    private func metric(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
