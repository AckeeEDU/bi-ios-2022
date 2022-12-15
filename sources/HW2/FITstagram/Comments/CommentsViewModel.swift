//
//  CommentsViewModel.swift
//  FITstagram
//
//  Created by Igor Rosocha on 09.11.2022.
//

import Foundation

class CommentsViewModel: ObservableObject {
    @Published private(set) var comments: [Comment] = []
    @Published private(set) var state: CommentsScreenState = .loading
    @Published var isNewCommentPresented = false
    
    let postID: Post.ID
    
    init(postID: Post.ID) {
        self.postID = postID
    }
    
    @MainActor
    func fetchComments() async {
        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed/\(postID)/comments")!)
        request.httpMethod = "GET"
        request.timeoutInterval = 2

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            self.comments = try JSONDecoder().decode([Comment].self, from: data)
            state = .comments(comments)
        } catch {
            state = .error(error)
            print("[ERROR]", error)
        }
    }
}
