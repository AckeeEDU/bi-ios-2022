//
//  ButtonsList.swift
//  imessage-extension
//
//  Created by Igor Rosocha on 07.12.2022.
//

import SwiftUI

struct ButtonsList: View {
    var body: some View {
        VStack(spacing: 0) {
            Button("First") {}
            Button("Second") {}
            Button("Third") {}
        }
    }
}

struct ButtonsListPreview: PreviewProvider {
    static var previews: some View {
        ButtonsList()
    }
}
