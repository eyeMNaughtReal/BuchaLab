import SwiftUI

struct StatusSection: View {
    let phase: FermentationPhase
    let days: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Current Status")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Current Phase")
                        .font(.subheadline)
                    Text(phase.rawValue)
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Days in Phase")
                        .font(.subheadline)
                    Text("\(days)")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(radius: 2)
        )
        .padding(.horizontal)
    }
} 