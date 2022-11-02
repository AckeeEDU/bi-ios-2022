//
//  NewCommentView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 19.10.2022.
//

import SwiftUI

struct NewCommentView: View {
    
    @State var comment = ""
    @Binding var isPresented: Bool
    
    let onNewComment: (String) -> Void
    
    var body: some View {
        VStack {
            TextField("New comment", text: $comment)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(
                            Color.black,
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.horizontal, 20)
            
            Button("Add comment") {
                onNewComment(comment)
                isPresented = false
            }
            .font(.footnote.bold())
            .disabled(comment.isEmpty)
        }
    }
}

struct NewCommentView_Previews: PreviewProvider {
    static var previews: some View {
        NewCommentView(
            isPresented: .constant(false),
            onNewComment: { _ in }
        )
    }
}
