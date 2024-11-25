import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    // State variables for UI
    @State private var enablepHAlerts = false
    @State private var enableTempAlerts = false
    @State private var enableBrewAlerts = false
    @State private var enableScobyAlerts = false
    @State private var preferredTemperatureUnit = "Fahrenheit"
    @State private var preferredVolumeUnit = "Gallons"
    @State private var preferredTheme = "System"
    
    private let temperatureUnits = ["Fahrenheit", "Celsius"]
    private let volumeUnits = ["Gallons", "Quarts", "Cups", "Fluid Ounces", "Liters", "Milliliters"]
    private let themeOptions = ["System", "Light", "Dark"]
    
    var body: some View {
        NavigationStack {
            List {
                // Notifications Section
                Section("Notifications") {
                    Toggle("pH Level Alerts", isOn: $enablepHAlerts)
                    Toggle("Temperature Alerts", isOn: $enableTempAlerts)
                    Toggle("Brew Progress Updates", isOn: $enableBrewAlerts)
                    Toggle("SCOBY Progress Updates", isOn: $enableScobyAlerts)
                }
                
                // Preferences Section
                Section("Measurement Units") {
                    Picker("Temperature", selection: $preferredTemperatureUnit) {
                        ForEach(temperatureUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    
                    Picker("Volume", selection: $preferredVolumeUnit) {
                        ForEach(volumeUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                
                // Appearance Section
                Section("Appearance") {
                    Picker("Theme", selection: $preferredTheme) {
                        ForEach(themeOptions, id: \.self) { theme in
                            Text(theme)
                        }
                    }
                }
                
                // About Section
                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.buchaLabTheme.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
} 