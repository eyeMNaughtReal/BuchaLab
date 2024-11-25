import SwiftUI

struct InstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    let waterAmount: Int
    let sugarAmount: Int
    
    // Helper function to format fractions
    private func formatMeasurement(quarters: Int, unit: String) -> String {
        let wholeNumber = quarters/4
        let fraction = quarters % 4
        
        if fraction == 0 {
            return "\(wholeNumber) \(unit)\(wholeNumber == 1 ? "" : "s")"
        } else if wholeNumber == 0 {
            return "\(fraction)/4 \(unit)"
        } else {
            return "\(wholeNumber) \(fraction)/4 \(unit)s"
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    instructionSection("1. Make Sweet Tea:", [
                        "Bring \(waterAmount) cups of water to a boil.",
                        "Add the tea bag and steep for 5–10 minutes.",
                        "Remove the tea bag and dissolve \(formatMeasurement(quarters: sugarAmount, unit: "cup")) of sugar into the hot tea. Stir until fully dissolved.",
                        "Let the tea cool to room temperature to avoid killing the live cultures in the kombucha."
                    ])
                    
                    instructionSection("2. Combine the Ingredients:", [
                        "Pour the cooled sweet tea into your clean glass jar.",
                        "Add the entire bottle of raw kombucha (including the sediment at the bottom, which contains yeast and bacteria)."
                    ])
                    
                    instructionSection("3. Cover and Ferment:", [
                        "Cover the jar with the breathable cloth or coffee filter, and secure it with a rubber band.",
                        "Place the jar in a warm, dark, and well-ventilated spot (around 75°F–85°F) for 1–4 weeks."
                    ])
                    
                    instructionSection("4. Monitor the SCOBY Formation:", [
                        "After a few days, you'll notice a translucent layer forming on the surface of the liquid. This is the beginning of your SCOBY.",
                        "Over time, the SCOBY will thicken and become more opaque, resembling a rubbery disk.",
                        "The process can take up to 4 weeks depending on temperature and environmental conditions."
                    ])
                    
                    instructionSection("5. Taste and Use:", [
                        "Taste the liquid by gently inserting a clean straw under the SCOBY. It should become tangy over time.",
                        "Once the SCOBY is at least 1/4-inch thick, you can use it to brew a full batch of kombucha."
                    ])
                    
                    instructionSection("Key Tips:", [
                        "Cleanliness: Always sanitize your tools and hands to avoid contamination.",
                        "Temperature: Avoid temperatures below 70°F or above 90°F, as they can inhibit or kill the culture.",
                        "Do Not Agitate: Keep the jar still to allow the SCOBY to form properly.",
                        "Flavor: The liquid may taste slightly different than store-bought kombucha, but this is normal."
                    ])
                }
                .padding()
            }
            .navigationTitle("Instructions")
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
            ForEach(steps, id: \.self) { step in
                Text("• \(step)")
                    .font(.subheadline)
            }
        }
    }
} 