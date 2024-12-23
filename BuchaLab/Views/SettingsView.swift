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
                notificationsSection
                measurementSection
                appearanceSection
                aboutSection
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .background(.background)
        }
    }
    
    private var notificationsSection: some View {
        Section {
            Toggle("pH level alerts", isOn: $enablepHAlerts)
            Toggle("Temperature alerts", isOn: $enableTempAlerts)
            Toggle("Brew progress updates", isOn: $enableBrewAlerts)
            Toggle("SCOBY progress updates", isOn: $enableScobyAlerts)
        } header: {
            Text("Notifications")
        } footer: {
            Text("Get notified when your brews need attention")
        }
    }
    
    private var measurementSection: some View {
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
    }
    
    private var appearanceSection: some View {
        Section("Appearance") {
            Picker("Theme", selection: $preferredTheme) {
                ForEach(themeOptions, id: \.self) { theme in
                    Text(theme)
                }
            }
        }
    }
    
    private var aboutSection: some View {
        Section("About") {
            HStack {
                Text("Version")
                Spacer()
                Text("1.0.0")
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    SettingsView()
} 