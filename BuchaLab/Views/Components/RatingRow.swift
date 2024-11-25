import SwiftUI

struct RatingRow: View {
    let label: String
    let value: Binding<Int>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color.buchaLabTheme.text)
            
            HStack {
                Text("1")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Slider(
                    value: Binding(
                        get: { Double(value.wrappedValue) },
                        set: { value.wrappedValue = Int($0) }
                    ),
                    in: 1...5,
                    step: 1
                )
                .tint(Color.buchaLabTheme.primary)
                
                Text("5")
                    .font(.caption)
                    .foregroundColor(.secondary)
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