import SwiftUI

struct EditProfileView: View {
    @AppStorage("username") var username = ""
    @State var image: UIImage?
    @State var isImagePickerPresented = false

    var body: some View {
        VStack(spacing: 16) {
            Rectangle()
                .fill(.gray)
                .aspectRatio(1, contentMode: .fit)
                .overlay {
                    if let image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .clipped()
                .overlay(
                    Button {
                        isImagePickerPresented = true
                    } label: {
                        Circle()
                            .fill(.white)
                            .frame(width: 64, height: 64)
                            .overlay(
                                Image(systemName: "pencil")
                                    .resizable()
                                    .padding()
                            )
                    }
                )

            TextField("Username", text: $username)
                .padding()
        }
        .fullScreenCover(isPresented: $isImagePickerPresented) {
            ImagePicker(
                image: $image,
                isPresented: $isImagePickerPresented
            )
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: Context
    ) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(image: $image, isPresented: $isPresented)
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: UIImage?
        @Binding var isPresented: Bool

        init(image: Binding<UIImage?>, isPresented: Binding<Bool>) {
            self._image = image
            self._isPresented = isPresented
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isPresented = false
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            guard let image = info[.originalImage] as? UIImage else { return }
            self.image = image
            self.isPresented = false
        }
    }


}
