//
//  ContentView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 12.10.2022.
//

import SwiftUI

struct ContentView: View {
    var posts = [
        Post(username: "Igor Rosocha", likes: 1240, description: "Top notch!", comments: 256),
        Post(username: "Igor Rosocha", likes: 1240, description: "Top notch!", comments: 256),
        Post(username: "Igor Rosocha", likes: 1240, description: "Top notch!", comments: 256)
    ]
    
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()]) {
                ForEach(posts) { post in
                    PostView(post: post)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
