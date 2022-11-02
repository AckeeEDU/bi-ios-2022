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
                .onAppear {
                    fetchImage()
                }
        }
    }

    private func fetchImage() {
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            let image = UIImage(data: data)!

            DispatchQueue.main.async {
                self.image = Image(uiImage: image)
            }
        }
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: URL(string: "https://placeimg.com/1024/640/nature")!)
    }
}
