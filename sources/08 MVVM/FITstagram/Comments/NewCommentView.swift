//
//  NewCommentView.swift
//  FITstagram
//
//  Created by Igor Rosocha on 19.10.2022.
//

import SwiftUI

//var username: String? {
//    get { UserDefaults.standard.value(forKey: "username") as? String }
//    set { UserDefaults.standard.set(newValue, forKey: "username") }
//}
//
//var _username: Defaults<String>
//var username: String? {
//    get { _username.wrappedValue }
//    set { _username.wrappedValue = newValue }
//}
//
//@propertyWrapper
//struct Defaults<Value> {
//    let key: String
//
//    var wrappedValue: Value? {
//        get { UserDefaults.standard.value(forKey: key) as? Value }
//        set { UserDefaults.standard.set(newValue, forKey: key) }
//    }
//
//    var projectedValue: String {
//        key
//    }
//}

struct AddCommentRequest: Encodable {
    let text: String
}

final class NewCommentViewModel: ObservableObject {
    @Binding var isPresented: Bool
    let onNewComment: (String) -> Void
    let postID: Post.ID

    @Published var comment = ""
    @Published var isLoading = false

    init(
        postID: Post.ID,
        isPresented: Binding<Bool>,
        onNewComment: @escaping (String) -> Void
    ) {
        self.postID = postID
        self._isPresented = isPresented
        self.onNewComment = onNewComment
    }

    @MainActor
    func addComment() async {
        isLoading = true
        defer { isLoading = false }

        guard !comment.isEmpty else { return }

        let url = URL(string: "https://fitstagram.ackee.cz/api/feed/\(postID)/comments")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Authorization": "hromalu1"
        ]

        let body = AddCommentRequest(text: comment)
        request.httpBody = try! JSONEncoder().encode(body)

        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            print(response)
            onNewComment(comment)
            isPresented = false
        } catch {
            print("[ERROR]", error.localizedDescription)
        }
    }
}

struct NewCommentView: View {
    @StateObject var viewModel: NewCommentViewModel
    
    var body: some View {
        VStack {
            TextField("New comment", text: $viewModel.comment)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(
                            Color.black,
                            style: StrokeStyle(lineWidth: 1.0)
                        )
                )
                .padding(.horizontal, 20)

            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                Button("Add comment") {
                    Task {
                        await viewModel.addComment()
                    }
                }
                .font(.footnote.bold())
                .disabled(viewModel.comment.isEmpty)
            }
        }
    }
}

struct NewCommentView_Previews: PreviewProvider {
    static var previews: some View {
        NewCommentView(
            viewModel: NewCommentViewModel(
                postID: "",
                isPresented: .constant(false),
                onNewComment: { _ in }
            )
        )
    }
}
