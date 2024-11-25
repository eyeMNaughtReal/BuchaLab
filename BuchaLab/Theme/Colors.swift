import SwiftUI

extension Color {
    static let buchaLabTheme = BuchaLabColors()
}

struct BuchaLabColors {
    let background = Color(hex: "E6D5C3")  // Warm beige background
    let primary = Color(hex: "4A665E")     // Dark sage green
    let secondary = Color(hex: "94A69A")   // Light sage green
    let accent = Color(hex: "FF7F5C")      // Coral orange
    let text = Color(hex: "2C3834")        // Dark text color
    let surface = Color(hex: "F5EDE4")     // Light cream for cards
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
} 
