import SwiftUI

struct RatingDisplay: View {
    let label: String
    let value: Int
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { rating in
                    Image(systemName: rating <= value ? "circle.fill" : "circle")
                        .font(.system(size: 8))
                        .foregroundColor(rating <= value ? Color.buchaLabTheme.primary : Color.buchaLabTheme.text.opacity(0.3))
                }
            }
        }
    }
} 