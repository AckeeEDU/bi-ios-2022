//
//  CommentsView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 19.10.2022.
//

import SwiftUI

struct CommentsView: View {
    @StateObject var viewModel: CommentsViewModel
    
    @State var sheetPresented = false
    
    var body: some View {
        CommentsContentView(state: viewModel.state)
            .refreshable {
                await viewModel.fetchComments()
            }
            .task {
                await viewModel.fetchComments()
            }
//        .sheet(isPresented: $sheetPresented) {
//            NewCommentView(
//                isPresented: $sheetPresented,
//                onNewComment: {
//                    comments.append(
//                        Comment(
//                            username: "dwight.schrute",
//                            text: $0
//                        )
//                    )
//                }
//            )
//        }
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
        CommentsView(viewModel: .init(postID: "1"))
    }
}
