import SwiftUI

struct PhaseTransitionView: View {
    @Environment(\.dismiss) private var dismiss
    let onComplete: (Bool) -> Void
    
    @State private var phChecked = false
    @State private var tasteChecked = false
    @State private var readyForTransition = false
    @State private var currentPh: Double = 3.0
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Before moving to Second Fermentation (2F), let's verify your brew is ready.")
                        .foregroundColor(Color.buchaLabTheme.text)
                } header: {
                    Text("Transition to 2F")
                }
                
                // pH Check
                Section {
                    Toggle(isOn: $phChecked) {
                        Text("I've checked the pH")
                    }
                    
                    if phChecked {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Current pH: \(String(format: "%.1f", currentPh))")
                                .font(.subheadline)
                            
                            Slider(value: $currentPh, in: 2.5...4.5, step: 0.1)
                        }
                        .padding(.leading)
                    }
                } header: {
                    Text("pH Level")
                } footer: {
                    Text("pH should be between 2.5 and 3.5 before moving to 2F")
                }
                
                // Taste Check
                Section {
                    Toggle(isOn: $tasteChecked) {
                        Text("I've tasted the brew")
                    }
                    
                    if tasteChecked {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Taste should be:")
                                .font(.subheadline)
                            Text("• Still slightly sweet")
                            Text("• Mildly tart/acidic")
                            Text("• Not vinegary")
                        }
                        .padding(.leading)
                    }
                } header: {
                    Text("Taste Test")
                } footer: {
                    Text("The brew should have a balance of sweetness and acidity")
                }
                
                // Ready Check
                Section {
                    Toggle(isOn: $readyForTransition) {
                        Text("Ready for 2F")
                    }
                } header: {
                    Text("Confirmation")
                } footer: {
                    if !phChecked || !tasteChecked {
                        Text("Complete the checks above before confirming")
                            .foregroundColor(.red)
                    } else if currentPh > 3.5 {
                        Text("pH is too high for 2F. Consider fermenting longer")
                            .foregroundColor(.red)
                    } else {
                        Text("Your brew appears ready for 2F!")
                            .foregroundColor(.green)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.buchaLabTheme.background)
            .navigationTitle("1F → 2F")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        onComplete(false)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Begin 2F") {
                        onComplete(true)
                        dismiss()
                    }
                    .disabled(!canTransition)
                }
            }
        }
    }
    
    private var canTransition: Bool {
        phChecked && 
        tasteChecked && 
        readyForTransition && 
        currentPh >= 2.5 && 
        currentPh <= 3.5
    }
}

#Preview {
    PhaseTransitionView { _ in }
} 