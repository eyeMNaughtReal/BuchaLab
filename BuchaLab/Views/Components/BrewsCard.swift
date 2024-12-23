import SwiftUI

struct BrewsCard: View {
    @State private var brewPhase = "1F" // Brew phase (First Fermentation)
    @State private var currentTemp: Double = 72.4 // Current temperature
    @State private var currentPh: Double = 3.4 // Current pH
    @State private var lastUpdated = Date() // Last updated timestamp
    
    var body: some View {
        NavigationLink(destination: BrewDetailView()) { // Navigation link to the details view
            ZStack {
                Color(uiColor: .systemGray6)
                    .cornerRadius(15)
                    .frame(width: 200, height: 250) // Ensures card size fits within the layout
                
                VStack(alignment: .leading, spacing: 8) {
                    // Brew Phase & Name
                    HStack {
                        Text(brewPhase) // Brew phase (1F or 2F)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(6)
                            .background(brewPhase == "1F" ? Color.blue.opacity(0.6) : Color.green.opacity(0.6))
                            .cornerRadius(8)
                        
                        Spacer()
                    }
                    
                    Text("Berry Blast") // The name of the brew
                        .font(.title2)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    // Brew Stats (Temperature, pH)
                    HStack {
                        Text("Temp: \(currentTemp, specifier: "%.1f")°F")
                            .font(.footnote)
                            .foregroundColor(currentTemp > 72 ? .green : .red)
                        
                        Spacer()
                        
                        Text("pH: \(currentPh, specifier: "%.1f")")
                            .font(.footnote)
                            .foregroundColor(currentPh > 3.0 ? .green : .red)
                    }
                    .padding(.bottom, 8)
                    
                    // Log button
                    Button(action: {
                        print("Log Taste Test")
                    }) {
                        Text("Log Taste Test")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.blue)
                            .cornerRadius(5)
                    }
                    
                    // Last Updated
                    let formatter = RelativeDateTimeFormatter()
                    let relativeTime = formatter.localizedString(for: lastUpdated, relativeTo: Date())
                    
                    Text("Last checked: \(relativeTime)")
                        .font(.caption2)
                        .italic()
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding()
            }
            .buttonStyle(PlainButtonStyle()) // Ensures the card doesn't show a button style when tapped
        }
    }
}

struct BrewDetailView: View {
    var body: some View {
        VStack {
            Text("Detailed Brew Information")
                .font(.largeTitle)
                .padding()
            // Here, you would add the details for the specific brew
            Text("This would be where detailed information about the brew is displayed.")
                .font(.body)
        }
    }
}

struct BrewsCard_Previews: PreviewProvider {
    static var previews: some View {
        BrewsCard()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
