import SwiftUI

struct RatingRow: View {
    let label: String
    @Binding var value: Int
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= value ? "star.fill" : "star")
                        .foregroundColor(index <= value ? .yellow : .gray)
                        .onTapGesture {
                            value = index
                        }
                }
            }
        }
    }
}

#Preview {
    Form {
        RatingRow(
            label: "Test Rating",
            value: .constant(3)
        )
    }
} 