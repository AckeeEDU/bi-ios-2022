//
//  CommentsView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 19.10.2022.
//

import SwiftUI

struct CommentsView: View {
    @State var comments = [
        Comment(username: "igor.rosocha", text: "❤️"),
        Comment(username: "lukas.hromadnik", text: "Pěkný"),
        Comment(username: "jakub.olejnik", text: "Proč bych chodil do přírody..."),
        Comment(username: "emoji.guru", text: "🏔🌅💦")
    ]

    @State var sheetPresented = false
    
    var body: some View {
        List {
            ForEach(comments) { comment in
                HStack {
                    Text(comment.username)
                        .fontWeight(.semibold)
                    
                    Text(comment.text)
                }
            }
            
            Button(action: {
                sheetPresented = true
            }) {
                Image(systemName: "plus")
            }
        }
        .listStyle(.grouped)
        .sheet(isPresented: $sheetPresented) {
            NewCommentView(
                isPresented: $sheetPresented,
                onNewComment: {
                    comments.append(
                        Comment(
                            username: "dwight.schrute",
                            text: $0
                        )
                    )
                }
            )
        }
//        .alert(
//            "Login",
//            isPresented: $alertDisplayed,
//            actions: {
//                TextField("Username", text: .constant(""))
//                SecureField("Password", text: .constant(""))
//
//                Button("Login", action: {})
//                Button("Cancel", role: .cancel, action: {})
//            }, message: {
//                Text("Please enter your username and password.")
//            }
//        )
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
