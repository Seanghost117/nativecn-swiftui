import SwiftUI

/// The semantic role for an alert dialog action.
public enum CNAlertDialogRole: String, CaseIterable, Sendable, Equatable {
    /// A normal confirmation action.
    case `default`

    /// A destructive confirmation action.
    case destructive

    /// The button variant for the role.
    public var buttonVariant: CNButton<Text>.Variant {
        switch self {
        case .default:
            return .primary
        case .destructive:
            return .destructive
        }
    }

    /// The native button role for the action.
    public var buttonRole: ButtonRole? {
        switch self {
        case .default:
            return nil
        case .destructive:
            return .destructive
        }
    }
}

/// A purpose-built confirmation dialog for consequential actions.
public struct CNAlertDialog: View {
    private let title: String
    private let message: String?
    private let cancelTitle: String
    private let actionTitle: String
    private let role: CNAlertDialogRole
    private let onCancel: () -> Void
    private let onAction: () -> Void

    /// Creates an alert dialog.
    public init(
        title: String,
        message: String? = nil,
        cancelTitle: String = "Cancel",
        actionTitle: String,
        role: CNAlertDialogRole = .destructive,
        onCancel: @escaping () -> Void,
        onAction: @escaping () -> Void
    ) {
        self.title = title
        self.message = message
        self.cancelTitle = cancelTitle
        self.actionTitle = actionTitle
        self.role = role
        self.onCancel = onCancel
        self.onAction = onAction
    }

    /// The alert dialog body.
    public var body: some View {
        CNDialog(title: title, message: message) {
            CNButton(cancelTitle, variant: .outline, action: onCancel)
            CNButton(actionTitle, variant: role.buttonVariant, role: role.buttonRole, action: onAction)
        }
    }
}

public extension View {
    /// Presents a purpose-built alert dialog overlay.
    func cnAlertDialog(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        cancelTitle: String = "Cancel",
        actionTitle: String,
        role: CNAlertDialogRole = .destructive,
        onCancel: (() -> Void)? = nil,
        onAction: @escaping () -> Void
    ) -> some View {
        cnDialog(isPresented: isPresented) {
            CNAlertDialog(
                title: title,
                message: message,
                cancelTitle: cancelTitle,
                actionTitle: actionTitle,
                role: role
            ) {
                isPresented.wrappedValue = false
                onCancel?()
            } onAction: {
                isPresented.wrappedValue = false
                onAction()
            }
        }
    }
}
