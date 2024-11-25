import SwiftUI

struct MonitoringSection: View {
    let ph: Double?
    let temperature: Double?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 20) {
                // pH Display
                VStack(alignment: .leading) {
                    Text("pH Level")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if let ph {
                        Text(String(format: "%.1f", ph))
                            .font(.title2)
                            .fontWeight(.semibold)
                    } else {
                        Text("--")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                
                // Temperature Display
                VStack(alignment: .leading) {
                    Text("Temperature")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if let temperature {
                        Text(String(format: "%.1f°", temperature))
                            .font(.title2)
                            .fontWeight(.semibold)
                    } else {
                        Text("--")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    MonitoringSection(ph: 3.2, temperature: 75.0)
} 