//
//  ActivityIndicator.swift
//  imessage-extension
//
//  Created by Igor Rosocha on 07.12.2022.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        activityIndicator.startAnimating()
    }
}
