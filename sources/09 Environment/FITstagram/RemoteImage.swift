import SwiftUI

struct RemoteImage: View {
    let url: URL
    @State private var image: Image?

    var body: some View {
        if let image = self.image {
            image
                .resizable()
        } else {
            ProgressView()
                .progressViewStyle(.circular)
                .task {
                    await fetchImage()
                }
        }
    }

    @MainActor
    private func fetchImage() async {
        let downloadImage = Task.detached {
            let data = try! Data(contentsOf: url)
            return UIImage(data: data)!
        }

        let image = await downloadImage.value
        self.image = Image(uiImage: image)
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: URL(string: "https://placeimg.com/1024/640/nature")!)
    }
}
