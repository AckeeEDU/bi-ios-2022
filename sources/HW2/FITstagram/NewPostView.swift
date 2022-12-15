import SwiftUI

struct NewPostRequest: Encodable {
    let text: String
    let photos: [String]
}

struct NewPostErrorResponse: Decodable {
    let message: String
}

enum NewPostError: LocalizedError {
    case validation(String)
    case network(Error)
    case api(String)

    var errorDescription: String? {
        switch self {
        case let .validation(text): return text
        case let .network(error): return error.localizedDescription
        case let .api(text): return text
        }
    }
}

extension UIImage {
    func imageSizeInPixel() -> CGSize {
        let heightInPoints = size.height
        let heightInPixels = heightInPoints * scale

        let widthInPoints = size.width
        let widthInPixels = widthInPoints * scale

        return CGSize(width: widthInPixels, height: heightInPixels)
    }

    func resized(to size: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1

        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}


final class NewPostViewModel: ObservableObject {
    @Published var description = ""
    @Published var isImagePickerShown = false
    @Published var image: UIImage?
    @Published var error: NewPostError?

    @MainActor
    func createPost() async {
        guard let image, let imageString = preparePhoto(image) else {
            error = .validation("Image is missing")
            return
        }

        guard !description.isEmpty else {
            error = .validation("Description is missing")
            return
        }

        var request = URLRequest(url: URL(string: "https://fitstagram.ackee.cz/api/feed")!)
        request.httpMethod = "POST"
        let requestBody = NewPostRequest(
            text: description,
            photos: [imageString]
        )
        request.httpBody = try? JSONEncoder().encode(requestBody)
        if let username = UserDefaults.standard.string(forKey: "username") {
            request.allHTTPHeaderFields = [
                "Authorization": username
            ]
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            print(response)
            print(String(data: data, encoding: .utf8))

            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 400
            if (400...499).contains(statusCode) {
                let message = try JSONDecoder().decode(NewPostErrorResponse.self, from: data)
                error = .api(message.message)
                return
            }
        } catch {
            self.error = .network(error)
        }
    }

    private func preparePhoto(_ photo: UIImage?) -> String? {
        guard let photo = photo else { return nil }

        var image = photo
        if max(photo.imageSizeInPixel().width, photo.imageSizeInPixel().height) > 2048 {
            let newWidth: CGFloat
            let newHeight: CGFloat

            if photo.size.height > photo.size.width {
                newHeight = 2048 / photo.scale
                newWidth = photo.size.width / photo.size.height * newHeight
            } else {
                newWidth = 2048 / photo.scale
                newHeight = photo.size.height / photo.size.width * newWidth
            }

            let size = CGSize(width: newWidth, height: newHeight)
            image = photo.resized(to: size)
        }

        return image.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

struct NewPostView: View {
    @StateObject var viewModel = NewPostViewModel()

    var body: some View {
        VStack {
            Button {
                viewModel.isImagePickerShown = true
            } label: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } else {
                            Label("Choose image", systemImage: "photo")
                                .foregroundColor(.blue)
                        }
                    }
                    .clipped()
            }
            .buttonStyle(.plain)

            TextField("Description", text: $viewModel.description)
                .padding(.horizontal)

            Button("Create post") {
                Task {
                    await viewModel.createPost()
                }
            }

            Spacer()
        }
        .sheet(isPresented: $viewModel.isImagePickerShown) {
            ImagePicker(image: $viewModel.image, isPresented: $viewModel.isImagePickerShown)
        }
        .alert(
            isPresented: Binding(
                get: { viewModel.error != nil },
                set: {
                    if !$0 {
                        viewModel.error = nil
                    }
                }
            ),
            error: viewModel.error,
            actions: { }
        )
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
