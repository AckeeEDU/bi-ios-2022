import SwiftUI

final class PostDetailViewModel: ObservableObject {
    @Published var post: Post?
    @Published var comments: [Comment] = []
    @Published var isFullscreen = false

    var isLoading: Bool {
        post == nil
    }

    let postID: Post.ID

    init(postID: Post.ID) {
        self.postID = postID
    }

    @MainActor
    func fetchDetail() async {
        do {
            comments = try await fetchComments()
            post = try await fetchPost()

//            (post, comments) = try await (fetchPost(), fetchComments())
        } catch {
            print("[ERROR]", error)
        }
    }

    private func fetchPost() async throws -> Post {
        let url = URL(string: "https://fitstagram.ackee.cz/api/feed/\(postID)")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }

    private func fetchComments() async throws -> [Comment] {
        let url = URL(string: "https://fitstagram.ackee.cz/api/feed/\(postID)/comments")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode([Comment].self, from: data)
    }
}

struct PostDetailView: View {
    @StateObject var viewModel: PostDetailViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(.circular)
                .task {
                    await viewModel.fetchDetail()
                }
        } else {
            mainView
                .refreshable {
                    await viewModel.fetchDetail()
                }
        }
    }

    private var mainView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if !viewModel.isFullscreen {
                    userHeaderView
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                }

                imagesView
                    .padding(.bottom, 16)

                if !viewModel.isFullscreen {
                    commentsHeaderView
                        .padding(.horizontal)
                        .padding(.bottom, 8)

                    commentsView
                        .padding(.horizontal)
                }
            }
        }
    }

    private var userHeaderView: some View {
        HStack {
            if let avatarURL = viewModel.post?.author.avatar {
                AsyncImage(url: avatarURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                }
                .clipShape(Circle())
                .frame(width: 32, height: 32)
            }

            Text(viewModel.post?.author.username ?? "")
                .bold()

            Spacer()
        }
    }

    private var imagesView: some View {
        TabView {
            ForEach(viewModel.post?.photos ?? [], id: \.self) { photo in
                AsyncImage(url: photo) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                }
                .onTapGesture {
                    withAnimation {
                        viewModel.isFullscreen.toggle()
                    }
                }
            }
        }
        .tabViewStyle(.page)
        .aspectRatio(viewModel.isFullscreen ? 0.5 : 1, contentMode: .fit)
        .zIndex(100)
    }

    private var commentsHeaderView: some View {
        HStack {
            Text("Komentáře")
                .bold()

            Spacer()

            Button {
                //
            } label: {
                Label("Přidat komentář", systemImage: "plus")
            }
        }
    }

    private var commentsView: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(viewModel.comments, id: \.id) { comment in
                Text("\(comment.author.username)  ").bold()
                +
                Text(comment.text)
            }
        }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(viewModel: PostDetailViewModel(postID: "1"))
    }
}
