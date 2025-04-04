import SwiftUI

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
			(a, r, g, b) = (255, 0, 0, 0)
		}
		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue: Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
	
	// Additional convenience methods
	
	// Returns hex string representation of the color
	var hexString: String {
		guard let components = cgColor?.components, components.count >= 3 else {
			return "#000000"
		}
		
		let r = Float(components[0])
		let g = Float(components[1])
		let b = Float(components[2])
		
		return String(format: "#%02lX%02lX%02lX",
									lroundf(r * 255),
									lroundf(g * 255),
									lroundf(b * 255))
	}
	
	// Returns color with adjusted brightness
	func adjusted(brightness: CGFloat) -> Color {
		var hue: CGFloat = 0
		var saturation: CGFloat = 0
		var brightness: CGFloat = 0
		var alpha: CGFloat = 0
		
#if canImport(UIKit)
		let uiColor = UIColor(self)
		uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		return Color(UIColor(hue: hue, saturation: saturation, brightness: min(max(brightness + brightness, 0.0), 1.0), alpha: alpha))
#else
		let nsColor = NSColor(self)
		nsColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
		return Color(NSColor(hue: hue, saturation: saturation, brightness: min(max(brightness + brightness, 0.0), 1.0), alpha: alpha))
#endif
	}
	
	// Returns color with adjusted opacity
	func withAlpha(_ alpha: CGFloat) -> Color {
#if canImport(UIKit)
		return Color(UIColor(self).withAlphaComponent(alpha))
#else
		return Color(NSColor(self).withAlphaComponent(alpha))
#endif
	}
}
