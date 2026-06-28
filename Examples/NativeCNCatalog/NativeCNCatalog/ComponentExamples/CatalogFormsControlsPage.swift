import NativeCN
import SwiftUI

struct CatalogFormsControlsPage: View {
    @State private var bio = ""
    @State private var otpCode = "123"
    @State private var notifications = true
    @State private var beta = false
    @State private var formats: Set<String> = ["bold"]
    @State private var volume = 0.72
    @State private var accepted = false
    @State private var plan = "pro"
    @State private var role: String? = "editor"
    @State private var nativeRole = "editor"
    @State private var team: String? = "design"
    @State private var workspace = "nativecn"
    @State private var price = "49"

    var body: some View {
        CatalogPage(
            title: "Forms & Controls",
            subtitle: "Textarea, switch, toggle, slider, checkbox, radio group, and select controls."
        ) {
            CNCard {
                CNCardHeader {
                    CNCardTitle("Form Example")
                    CNCardDescription("A settings-style form built from Phase 6 controls.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 18) {
                        CNField(label: "Bio", description: "Multiline native editing.", error: bio.isEmpty ? "Bio is required." : nil) {
                            CNTextarea("Tell us about yourself", text: $bio, minHeight: 110, maxHeight: 180)
                        }

                        CNField(label: "Verification code", description: "One-time passcode with grouped slots.") {
                            CNInputOTP(text: $otpCode, length: 6, groupSize: 3)
                        }

                        CNSwitch("Notifications", isOn: $notifications)
                        CNCheckbox("Accept terms", isOn: $accepted)

                        CNField(label: "Role") {
                            CNSelect(
                                "Role",
                                selection: $role,
                                options: [
                                    CNSelectOption("Admin", value: "admin"),
                                    CNSelectOption("Editor", value: "editor"),
                                    CNSelectOption("Viewer", value: "viewer"),
                                ]
                            )
                        }

                        CNField(label: "Native role", description: "Picker-backed native presentation.") {
                            CNNativeSelect(
                                "Native role",
                                selection: $nativeRole,
                                options: [
                                    CNSelectOption("Admin", value: "admin"),
                                    CNSelectOption("Editor", value: "editor"),
                                    CNSelectOption("Viewer", value: "viewer"),
                                ]
                            )
                        }

                        CNField(label: "Team", description: "Searchable selection for larger option sets.") {
                            CNCombobox(
                                "Team",
                                selection: $team,
                                options: [
                                    CNComboboxOption("Design Systems", value: "design", subtitle: "Tokens, components, and catalog", systemImage: "paintpalette", keywords: ["components", "tokens"]),
                                    CNComboboxOption("Platform", value: "platform", subtitle: "Build, release, and infrastructure", systemImage: "server.rack", keywords: ["infra", "build"]),
                                    CNComboboxOption("Product", value: "product", subtitle: "Roadmap and customer workflows", systemImage: "sparkles", keywords: ["roadmap"]),
                                    CNComboboxOption("Support", value: "support", subtitle: "Docs, triage, and enablement", systemImage: "lifepreserver", keywords: ["help", "docs"]),
                                ],
                                searchPlaceholder: "Search teams"
                            )
                        }
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Input Group")
                    CNCardDescription("Inputs with compact add-ons for URLs, currency, and units.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 14) {
                        CNInputGroup("workspace", text: $workspace, trailingText: ".app")
                        CNInputGroup("Price", text: $price, leadingText: "$")
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Toggles")
                    CNCardDescription("Single and grouped multi-select controls.")
                }

                CNCardContent {
                    VStack(alignment: .leading, spacing: 16) {
                        CNToggle("Beta features", isOn: $beta)

                        CNToggleGroup(
                            selection: $formats,
                            options: [
                                CNToggleGroupOption("Bold", value: "bold", systemImage: "bold"),
                                CNToggleGroupOption("Italic", value: "italic", systemImage: "italic"),
                                CNToggleGroupOption("Underline", value: "underline", systemImage: "underline"),
                            ]
                        )
                    }
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Slider")
                    CNCardDescription("Native slider with tokenized tint and value display.")
                }

                CNCardContent {
                    CNSlider(value: $volume, label: "Volume", showsValue: true)
                }
            }

            CNCard {
                CNCardHeader {
                    CNCardTitle("Radio Group")
                    CNCardDescription("Single selection with descriptions.")
                }

                CNCardContent {
                    CNRadioGroup(
                        selection: $plan,
                        options: [
                            CNRadioOption("Free", value: "free", description: "Personal experiments"),
                            CNRadioOption("Pro", value: "pro", description: "Production apps"),
                            CNRadioOption("Team", value: "team", description: "Shared workspaces"),
                        ]
                    )
                }
            }
        }
    }
}
