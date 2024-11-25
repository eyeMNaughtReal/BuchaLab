import SwiftUI

struct FirstFermentationInstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    let waterAmount: Int
    let sugarAmount: Int
    let teaBags: Int
    let starterAmount: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Ingredients Section
                    instructionSection("1. Ingredients:", [
                        "\(waterAmount) cups of water",
                        "\(sugarAmount) cup of white granulated sugar",
                        "\(teaBags) tea bags (black or green tea, avoid flavored teas with oils)",
                        "\(starterAmount) cup of starter tea",
                        "Your SCOBY"
                    ])
                    
                    // Equipment Section
                    instructionSection("2. Equipment:", [
                        "Clean glass jar (1-gallon size)",
                        "Clean straw for tasting",
                        "Breathable cloth or coffee filter",
                        "Rubber band",
                        "Thermometer",
                        "pH strip or digital pH meter (optional, but recommended)"
                    ])
                    
                    // Brew Steps
                    instructionSection("3. Brew the Sweet Tea:", [
                        "Bring \(waterAmount/2) cups of water to a boil",
                        "Add \(sugarAmount) cup of sugar and stir until dissolved",
                        "Add \(teaBags) tea bags and steep for 5–10 minutes",
                        "Remove tea bags and let sweet tea cool completely to room temperature (70°F - 80°F)",
                        "Note: Adding the SCOBY to hot tea could kill it"
                    ])
                    
                    instructionSection("4. Prepare the Fermentation Vessel:", [
                        "Pour the cooled sweet tea into your clean jar",
                        "Add \(waterAmount/2) more cups of water, leaving some room at the top",
                        "Add \(starterAmount) cup of starter tea and stir gently",
                        "Carefully place the SCOBY into the jar with clean hands"
                    ])
                    
                    instructionSection("5. Check Initial pH:", [
                        "After adding SCOBY and starter tea, check pH:"
                    ])
                    Group {
                        Text("• Should be between 3.5 and 4.5")
                            .font(.subheadline)
                            .foregroundColor(Color.buchaLabTheme.text)
                            .padding(.leading, 32)
                        Text("• If above 4.5, add more starter tea")
                            .font(.subheadline)
                            .foregroundColor(Color.buchaLabTheme.text)
                            .padding(.leading, 32)
                    }
                    .padding(.top, -16) // Adjust spacing between header and bullet points
                    
                    instructionSection("6. Cover and Ferment:", [
                        "Cover jar with breathable cloth/filter secured with rubber band",
                        "Place in warm, dark place away from sunlight and drafts",
                        "Maintain temperature between 75°F to 85°F (24°C to 29°C)"
                    ])
                    
                    instructionSection("7. Harvesting (7-14 days):", [
                        "Remove SCOBY with clean hands/tongs",
                        "Reserve 1-2 cups for next batch",
                        "Check final pH (should be 2.5-4.0)",
                        "Optional: Strain through sieve",
                        "Ready for 2F or immediate consumption"
                    ])
                    
                    // Updated Daily Monitoring section
                    Text("Daily Monitoring:")
                        .font(.headline)
                        .foregroundColor(Color.buchaLabTheme.primary)
                    
                    Group {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Temperature:")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                            Text("Check daily with thermometer")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                            Text("Below 75°F: Use heating mat or move to warmer spot")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                            Text("Above 85°F: Move to cooler area")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("pH Levels:")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                            Text("Day 1: Ensure pH is below 4.5")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                            Text("Day 3: Check again")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                            Text("Continue checking every few days (maintain 2.5-4.0)")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Taste Testing:")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                            Text("Start tasting after Day 5-7")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                            Text("Too sweet? Let it ferment longer")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                            Text("Too tart? It may be over-fermented")
                                .font(.subheadline)
                                .foregroundColor(Color.buchaLabTheme.text)
                                .padding(.leading)
                        }
                    }
                    .padding(.leading)
                }
                .padding()
            }
            .navigationTitle("1F Instructions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func instructionSection(_ title: String, _ steps: [String]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.buchaLabTheme.primary)
            ForEach(steps, id: \.self) { step in
                Text("• \(step)")
                    .font(.subheadline)
                    .foregroundColor(Color.buchaLabTheme.text)
            }
        }
    }
}

#Preview {
    FirstFermentationInstructionsView(
        waterAmount: 8,
        sugarAmount: 1,
        teaBags: 6,
        starterAmount: 2
    )
} 