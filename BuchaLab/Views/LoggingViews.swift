import SwiftUI
import Foundation

struct LogPHView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pH: Double = 3.2
    var onSave: (LogEntry) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(pH, specifier: "%.1f")")
                    .font(.system(size: 72, weight: .light))
                    .foregroundColor(.primary)
                    .padding()
                
                Slider(value: $pH, in: 2.5...4.5)
                    .tint(.blue)
                    .padding(.horizontal)
                
                Text("Recommended: 2.5-3.5")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Log pH")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(LogEntry(type: .ph, value: pH))
                        dismiss()
                    }
                }
            }
        }
    }
}

struct LogTemperatureView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var temperature: Double = 72.0
    var onSave: (LogEntry) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(temperature, specifier: "%.1f")°F")
                    .font(.system(size: 72, weight: .light))
                    .foregroundColor(.primary)
                    .padding()
                
                Slider(value: $temperature, in: 60...85)
                    .tint(.blue)
                    .padding(.horizontal)
                
                Text("Recommended: 68-78°F")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Log Temperature")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(LogEntry(type: .temperature, value: temperature))
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    LogPHView { _ in }
}

#Preview("Temperature") {
    LogTemperatureView { _ in }
} 