import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Circle()
                        .frame(width: 64, height: 64)

                    Text("username")
                }

                LazyVGrid(
                    columns: [
                        GridItem(spacing: 1),
                        GridItem(spacing: 1),
                        GridItem(spacing: 1)
                    ],
                    spacing: 1
                ) {
                    ForEach(0..<21) { i in
                        Rectangle()
                            .fill(.clear)
                            .aspectRatio(1, contentMode: .fill)
                            .overlay(
//                                AsyncImage(
//                                    url: URL(string: "https://placeimg.com/640/480/nature"),
//                                    content: { image in
//                                        image
//                                            .resizable()
//                                            .scaledToFill()
//                                    },
//                                    placeholder: {
//                                        ProgressView()
//                                            .progressViewStyle(.circular)
//                                    }
//                                )
                                RemoteImage(url: URL(string: "https://placeimg.com/640/480/nature")!)
                            )
                            .clipped()
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
