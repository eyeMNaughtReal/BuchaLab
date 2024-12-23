import SwiftUI

struct MeasurementButton: View {
    let icon: String
    let value: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                Text(value)
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)

            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
} 
