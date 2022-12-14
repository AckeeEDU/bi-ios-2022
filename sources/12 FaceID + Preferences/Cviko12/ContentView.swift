//
//  ContentView.swift
//  Cviko12
//
//  Created by Lukáš Hromadník on 14.12.2022.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @State private var text: String?

    var body: some View {
        VStack {
            Button("Authenticate", action: authenticate)
            if let text {
                Text(text)
            }
        }
    }

    func authenticate() {
        let context = LAContext()
        switch context.biometryType {
        case .none:
            break
        case .touchID:
            break
        case .faceID:
            break
        @unknown default:
            break
        }

        var error: NSError?
        let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
        if context.canEvaluatePolicy(policy, error: &error) {
            context.evaluatePolicy(policy, localizedReason: "Přístup do aplikace") { success, error in
                if let error {
                    text = error.localizedDescription
                    return
                }

                guard success else { assertionFailure(); return }

                text = "Authenticated"
            }
        } else {
            // You shall not pass
            text = error?.localizedDescription
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
