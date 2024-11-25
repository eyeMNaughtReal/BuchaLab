import Foundation

// MARK: - Fermentation Phase
enum FermentationPhase: String, CaseIterable {
    case firstFermentation = "1F"
    case secondFermentation = "2F"
    case completed = "Completed"
    case scoby = "SCOBY"
    
    var shortName: String {
        return self.rawValue
    }
}

// MARK: - Taste Log
struct TasteLog: Identifiable {
    let id = UUID()
    let timestamp: Date
    let sweetness: Int // 1-5 scale
    let tartness: Int // 1-5 scale
    let comments: String?
    let phase: FermentationPhase
    
    // First Fermentation specific fields
    let acidity: AcidityLevel?
    let readyForBottling: Bool?
    
    // Second Fermentation specific fields
    let carbonation: Int? // 1-5 scale
    let flavorStrength: Int? // 1-5 scale
    let addedFlavor: String?
    let batchReady: Bool?
    
    // SCOBY specific fields
    let acidityNotes: String?
    let offNotes: String?
    let texture: String?
    let scobyReady: Bool?
    
    enum AcidityLevel: String, CaseIterable, Identifiable {
        case tooLow = "Too Low"
        case balanced = "Balanced"
        case tooHigh = "Too High"
        
        var id: String { self.rawValue }
    }
}
