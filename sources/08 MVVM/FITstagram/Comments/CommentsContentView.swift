//
//  CommentsContentView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 09.11.2022.
//

import SwiftUI

struct CommentsContentView: View {
    let state: CommentsScreenState
    let onNewComment: () -> Void
    
    var body: some View {
        switch state {
        case .loading:
            ProgressView()

        case .error(let error):
            Text(error.localizedDescription)
                .foregroundColor(.red)

        case .comments(let comments):
            List {
                ForEach(comments) { comment in
                    HStack {
                        Text(comment.author.username)
                            .fontWeight(.semibold)
                        
                        Text(comment.text)
                    }
                }

                Button {
                    onNewComment()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct CommentsContentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsContentView(
            state: .comments(
                [
                    .init(id: "1", author: .init(id: "1", username: "igor.hromadnik"),
                          text: "❤️❤️❤️"),
                    .init(id: "2", author: .init(id: "2", username: "lukas.olejnik"),
                          text: "🏎🏎🏎"),
                    .init(id: "3", author: .init(id: "3", username: "jakub.rosocha"),
                          text: "🤷‍♂️🤷‍♂️🤷‍♂️")
                ]
            ),
            onNewComment: { }
        )
    }
}
