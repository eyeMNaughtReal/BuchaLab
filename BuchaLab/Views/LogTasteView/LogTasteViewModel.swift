import SwiftUI

class LogTasteViewModel: ObservableObject {
    // Common fields
    @Published var sweetness = 3
    @Published var tartness = 3
    @Published var comments = ""
    
    // First Fermentation fields
    @Published var acidity: TasteLog.AcidityLevel = .balanced
    @Published var readyForBottling = false
    
    // Second Fermentation fields
    @Published var carbonation = 3
    @Published var flavorStrength = 3
    @Published var addedFlavor = ""
    @Published var batchReady = false
    
    // SCOBY fields
    @Published var acidityNotes = ""
    @Published var offNotes = ""
    @Published var texture = ""
    @Published var scobyReady = false
    
    func createTasteLog(phase: FermentationPhase?) -> TasteLog {
        TasteLog(
            timestamp: Date(),
            sweetness: sweetness,
            tartness: tartness,
            comments: comments.isEmpty ? nil : comments,
            phase: phase ?? .scoby,
            // First Fermentation
            acidity: phase == .firstFermentation ? acidity : nil,
            readyForBottling: phase == .firstFermentation ? readyForBottling : nil,
            // Second Fermentation
            carbonation: phase == .secondFermentation ? carbonation : nil,
            flavorStrength: phase == .secondFermentation ? flavorStrength : nil,
            addedFlavor: phase == .secondFermentation && !addedFlavor.isEmpty ? addedFlavor : nil,
            batchReady: phase == .secondFermentation ? batchReady : nil,
            // SCOBY
            acidityNotes: phase == .scoby && !acidityNotes.isEmpty ? acidityNotes : nil,
            offNotes: phase == .scoby && !offNotes.isEmpty ? offNotes : nil,
            texture: phase == .scoby && !texture.isEmpty ? texture : nil,
            scobyReady: phase == .scoby ? scobyReady : nil
        )
    }
    
    func reset() {
        sweetness = 3
        tartness = 3
        comments = ""
        acidity = .balanced
        readyForBottling = false
        carbonation = 3
        flavorStrength = 3
        addedFlavor = ""
        batchReady = false
        acidityNotes = ""
        offNotes = ""
        texture = ""
        scobyReady = false
    }
} 