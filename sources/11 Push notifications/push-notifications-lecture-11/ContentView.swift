//
//  ContentView.swift
//  push-notifications-lecture-11
//
//  Created by Igor Rosocha on 07.12.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var pushManager = PushManager.shared
    
    var body: some View {
        Text("Push notification demo")
            .font(.title)
            .padding()
            .alert(item: $pushManager.notificationAlert) { alert in
                Alert(
                    title: Text(alert.alertTitle),
                    message: Text(alert.alertMessage),
                    primaryButton: .default(Text(alert.alertButtonTitle)),
                    secondaryButton: .cancel()
                )
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
