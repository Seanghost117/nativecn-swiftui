import NativeCN
import SwiftUI

struct CatalogInputPage: View {
    @State private var email = ""
    @State private var search = "NativeCN"
    @State private var amount = "49"
    @FocusState private var emailFocused: Bool

    var body: some View {
        CatalogPage(
            title: "Input & Field",
            subtitle: "Native TextField editing wrapped in tokenized field layout, labels, descriptions, and errors."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Field Layout")
                    CNCardDescription("CNField propagates invalid state to child inputs.")
                }

                CNCardContent {
                    VStack(spacing: 16) {
                        CNField(label: "Email", description: "Use your work email.", error: email.isEmpty ? "Email is required." : nil, isRequired: true) {
                            CNInput("Email", text: $email, keyboardType: .emailAddress, focus: $emailFocused)
                        }

                        CNField(label: "Search") {
                            CNInput("Search", text: $search, leadingIcon: "magnifyingglass")
                        }

                        CNField(label: "Amount") {
                            CNInput("Amount", text: $amount, trailing: {
                                Text("USD")
                            })
                        }

                        CNField(label: "Disabled") {
                            CNInput("Disabled", text: .constant("Read only"), isDisabled: true)
                        }
                    }
                }

                CNCardFooter {
                    CNButton(emailFocused ? "Focused" : "Focus Email") {
                        emailFocused = true
                    }
                }
            }
        }
    }
}
