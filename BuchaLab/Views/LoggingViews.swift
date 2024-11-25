import SwiftUI
import Foundation

struct LogPHView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var phValue: Double = 3.0
    @State private var notes: String = ""
    let onSave: (LogEntry) -> Void
    
    private let phValues: [Double] = stride(from: 2.5, through: 7.0, by: 0.1).map { 
        Double(round(10 * $0) / 10)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("pH Level", selection: $phValue) {
                        ForEach(phValues, id: \.self) { value in
                            Text(String(format: "%.1f", value))
                                .tag(value)
                        }
                    }
                } header: {
                    Text("pH Reading")
                } footer: {
                    Text("Select the pH level measured from your brew")
                }
                
                Section {
                    TextEditor(text: $notes)
                        .frame(minHeight: 100)
                } header: {
                    Text("Notes")
                } footer: {
                    Text("Add any additional observations (optional)")
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.buchaLabTheme.background)
            .navigationTitle("Log pH")
            .navigationBarTitleDisplayMode(.inline)
            .tint(Color.buchaLabTheme.primary)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color.buchaLabTheme.primary)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(LogEntry(
                            timestamp: Date(),
                            type: .ph,
                            value: phValue,
                            notes: notes.isEmpty ? nil : notes
                        ))
                        dismiss()
                    }
                    .foregroundColor(Color.buchaLabTheme.primary)
                }
            }
        }
    }
}

struct LogTemperatureView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var tempValue: Double = 70.0
    @State private var tempString: String = "70.0"
    let onSave: (LogEntry) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        TextField("Temperature", text: $tempString)
                            .keyboardType(.decimalPad)
                            .onChange(of: tempString) { oldValue, newValue in
                                if let value = Double(newValue) {
                                    tempValue = value
                                }
                            }
                        Spacer()
                        Stepper("", value: $tempValue, in: 0...100, step: 0.1)
                            .onChange(of: tempValue) { oldValue, newValue in
                                tempString = String(format: "%.1f", newValue)
                            }
                    }
                } header: {
                    Text("Temperature Reading")
                } footer: {
                    Text("Enter the temperature measured from your brew")
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.buchaLabTheme.background)
            .navigationTitle("Log Temp")
            .navigationBarTitleDisplayMode(.inline)
            .tint(Color.buchaLabTheme.primary)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color.buchaLabTheme.primary)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(LogEntry(
                            timestamp: Date(),
                            type: .temperature,
                            value: tempValue,
                            notes: ""
                        ))
                        dismiss()
                    }
                    .foregroundColor(Color.buchaLabTheme.primary)
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