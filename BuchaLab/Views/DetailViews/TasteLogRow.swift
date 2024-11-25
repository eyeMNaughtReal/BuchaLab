import SwiftUI

struct TasteLogRow: View {
    let log: TasteLog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Date Header
            Text(log.timestamp.formatted(date: .abbreviated, time: .shortened))
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Common Fields
            HStack(spacing: 16) {
                RatingDisplay(label: "Sweetness", value: log.sweetness)
                RatingDisplay(label: "Tartness", value: log.tartness)
            }
            
            // Conditional Fields based on fermentation stage
            switch log.phase {
            case .firstFermentation:
                if let acidity = log.acidity {
                    Text("Acidity: \(acidity.rawValue)")
                        .font(.subheadline)
                }
                if let readyForBottling = log.readyForBottling {
                    Text(readyForBottling ? "Ready for Bottling" : "Not Ready for Bottling")
                        .font(.subheadline)
                        .foregroundColor(readyForBottling ? .green : .orange)
                }
                
            case .secondFermentation:
                if let carbonation = log.carbonation {
                    RatingDisplay(label: "Carbonation", value: carbonation)
                }
                if let flavorStrength = log.flavorStrength {
                    RatingDisplay(label: "Flavor", value: flavorStrength)
                }
                if let addedFlavor = log.addedFlavor, !addedFlavor.isEmpty {
                    Text("Flavors: \(addedFlavor)")
                        .font(.subheadline)
                }
                if let batchReady = log.batchReady {
                    Text(batchReady ? "Batch Ready" : "Still Fermenting")
                        .font(.subheadline)
                        .foregroundColor(batchReady ? .green : .orange)
                }
                
            case .scoby:
                if let acidityNotes = log.acidityNotes, !acidityNotes.isEmpty {
                    Text("Acidity Notes: \(acidityNotes)")
                        .font(.subheadline)
                }
                if let offNotes = log.offNotes, !offNotes.isEmpty {
                    Text("Off Notes: \(offNotes)")
                        .font(.subheadline)
                }
                if let texture = log.texture, !texture.isEmpty {
                    Text("Texture: \(texture)")
                        .font(.subheadline)
                }
                if let scobyReady = log.scobyReady {
                    Text(scobyReady ? "SCOBY Ready" : "Still Developing")
                        .font(.subheadline)
                        .foregroundColor(scobyReady ? .green : .orange)
                }
                
            case .completed:
                Text("Batch Completed")
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            
            // Comments if any
            if let comments = log.comments, !comments.isEmpty {
                Text("Notes: \(comments)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
