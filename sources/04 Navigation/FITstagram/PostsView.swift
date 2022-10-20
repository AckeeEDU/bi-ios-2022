//
//  PostsView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 19.10.2022.
//

import SwiftUI

struct PostsView: View {
    var posts = [
        Post(username: "Igor Rosocha", likes: 1280, description: "Top notch!", comments: 256),
        Post(username: "Lukáš Hromadník", likes: 720, description: "Wow!", comments: 128),
        Post(username: "Jakub Olejník", likes: 480, description: "Wonderful, I love it!", comments: 64)
    ]
    
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: [GridItem()]) {
                    ForEach(posts) { post in
                        PostView(post: post)
                            .onTapGesture {
                                path.append(post)
                            }
                    }
                }
            }
            .navigationDestination(for: String.self) { string in
                Text(string)
            }
            .navigationDestination(for: Int.self) { integer in
                Text("\(integer)")
            }
            .navigationDestination(for: Post.self) { post in
                VStack {
                    Text(post.username)
                    
                    Text("\(post.comments)")
                    
                    Button("PUSH FIRST POST") {
                        path.append(posts[0])
                    }
                    
                    Button("POP TO ROOT!") {
                        path.removeLast(path.count)
                    }
                }
            }
            .navigationTitle("FITstagram")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
