//
//  PostsView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 19.10.2022.
//

import SwiftUI

//{
//    "postedAt" : "2022-04-15T08:46:01Z",
//    "text" : "đ¤",
//    "id" : "E7574AAB-2E6F-43EE-A803-1234953DC36A",
//    "photos" : [
//        "https:\/\/fitstagram.ackee.cz:443\/images\/176C9C71-9FB9-47C8-BE0C-27C9700E3A5C.jpg"
//    ],
//    "likes" : [
//
//    ],
//    "numberOfComments" : 0,
//    "author" : {
//        "username" : "zatim_bez_nazvu",
//        "id" : "C455A70A-A20F-4CAB-8940-F260AFB2F4C6"
//    }
//}


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
            .onAppear {
                fetchPosts()
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

    private func fetchPosts() {
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed/")!)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                print("[ERROR]", error)
                return
            }

            if let data {
                print("[DATA]", String(data: data, encoding: .utf8)!)
            }
        }
        task.resume()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
