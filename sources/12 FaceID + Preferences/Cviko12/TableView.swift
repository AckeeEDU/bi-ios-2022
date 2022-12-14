import SwiftUI

struct ColumnWidthPreferenceKey: PreferenceKey {
    static var defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int : CGFloat], nextValue: () -> [Int : CGFloat]) {
        value.merge(nextValue()) { max($0, $1) }
    }
}

extension View {
    func setColumnWidth(column: Int, width: Double) -> some View {
        preference(key: ColumnWidthPreferenceKey.self, value: [column: width])
    }
}

struct TableView: View {
    @State private var columnWidths: [Int: CGFloat] = [:]

    private let texts: [[String]] = {
        var texts: [[String]] = []
        for _ in 0..<10 {
            var row: [String] = []
            for _ in 0..<5 {
                let randomLength = Int.random(in: 1...5)
                var text = ""
                for _ in 0..<randomLength {
                    let letter = String("qwertzuiopasdfghjklyxcvbnm").randomElement()!
                    text.append(letter)
                }
                row.append(text)
            }
            texts.append(row)
        }
        return texts
    }()

    var body: some View {
        VStack {
            ForEach(0..<texts.count) { row in
                HStack {
                    ForEach(0..<texts[row].count) { column in
                        Text(texts[row][column])
                            .frame(width: columnWidths[column], alignment: .leading)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear.setColumnWidth(column: column, width: proxy.size.width)
                                }
                            )
                    }
                }
            }
        }
        .onPreferenceChange(ColumnWidthPreferenceKey.self) { value in
            columnWidths = value
        }
    }
}
