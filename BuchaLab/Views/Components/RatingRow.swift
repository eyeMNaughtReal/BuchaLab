import SwiftUI

struct RatingRow: View {
    let label: String
    @Binding var value: Int
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { index in
                    Circle()
                        .fill(index <= value ? Color.buchaLabTheme.primary : Color.buchaLabTheme.text.opacity(0.3))
                        .frame(width: 8, height: 8)
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