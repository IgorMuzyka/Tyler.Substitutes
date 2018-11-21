
import Style

public struct Color {

	let red: Number
	let green: Number
	let blue: Number
	let alpha: Number

	public init(red: Number, green: Number, blue: Number, alpha: Number = 1) {
		self.red = red
		self.green = green
		self.blue = blue
		self.alpha = alpha
	}
}

extension Color {

	public init(hex3: UInt16, alpha: Number = 1) {
		let divisor: Double = 15
		let red = Number(Double((hex3 & 0xF00) >> 8) / divisor)
		let green = Number(Double((hex3 & 0x0F0) >> 4) / divisor)
		let blue = Number(Double(hex3 & 0x00F) / divisor)
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	public init(hex4: UInt16) {
		let divisor: Double = 15
		let red = Number(Double((hex4 & 0xF000) >> 12) / divisor)
		let green = Number(Double((hex4 & 0x0F00) >> 8) / divisor)
		let blue = Number(Double((hex4 & 0x00F0) >> 4) / divisor)
		let alpha = Number(Double( hex4 & 0x000F) / divisor)
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	public init(hex6: UInt32, alpha: Number = 1) {
		let divisor: Double = 255
		let red = Number(Double((hex6 & 0xFF0000) >> 16) / divisor)
		let green = Number(Double((hex6 & 0x00FF00) >> 8) / divisor)
		let blue = Number(Double( hex6 & 0x0000FF) / divisor)
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	public init(hex8: UInt32) {
		let divisor: Double = 255
		let red = Number(Double((hex8 & 0xFF000000) >> 24) / divisor)
		let green = Number(Double((hex8 & 0x00FF0000) >> 16) / divisor)
		let blue = Number(Double((hex8 & 0x0000FF00) >> 8) / divisor)
		let alpha = Number(Double( hex8 & 0x000000FF) / divisor)
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}
}

extension Color: Codable {

	public enum ColorCodingError: Error {
		case decoding(String)
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()

		guard let value = try? container.decode(String.self) else {
			throw ColorCodingError.decoding("\(dump(container))")
		}

		guard value.hasPrefix("#") else {
			throw ColorCodingError.decoding("\(dump(container))")
		}

		let hexString: String = String(value[String.Index.init(encodedOffset: 1)...])
		var hexValue: UInt32 = 0

		guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
			throw ColorCodingError.decoding("\(dump(container))")
		}

		switch hexString.count {
		case 3: self.init(hex3: UInt16(hexValue))
		case 4: self.init(hex4: UInt16(hexValue))
		case 6: self.init(hex6: hexValue)
		case 8: self.init(hex8: hexValue)
		default: throw ColorCodingError.decoding("\(dump(container))")
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		var value: String

		if alpha.value != 1 {
			value = String(format: "#%02X%02X%02X%02X", Int(red.value * 255), Int(green.value * 255), Int(blue.value * 255), Int(alpha.value * 255))
		} else {
			value = String(format: "#%02X%02X%02X", Int(red.value * 255), Int(green.value * 255), Int(blue.value * 255))
		}

		try container.encode(value)
	}
}

extension Color {

	public static var black: Color { return Color(red: 0, green: 0, blue: 0) }
	public static var darkGray: Color { return Color(red: 0.333, green: 0.333, blue: 0.333) }
	public static var lightGray: Color { return Color(red: 0.667, green: 0.667, blue: 0.667) }
	public static var white: Color { return Color(red: 1, green: 1, blue: 1) }
	public static var gray: Color { return Color(red: 0.5, green: 0.5, blue: 0.5) }
	public static var red: Color { return Color(red: 1, green: 0, blue: 0) }
	public static var green: Color { return Color(red: 0, green: 1, blue: 0) }
	public static var blue: Color { return Color(red: 0, green: 0, blue: 1) }
	public static var cyan: Color { return Color(red: 0, green: 1, blue: 1) }
	public static var yellow: Color { return Color(red: 1, green: 1, blue: 0) }
	public static var magenta: Color { return Color(red: 1, green: 0, blue: 1) }
	public static var orange: Color { return Color(red: 1, green: 0.5, blue: 0) }
	public static var purple: Color { return Color(red: 0.5, green: 0, blue: 0.5) }
	public static var brown: Color { return Color(red: 0.6, green: 0.4, blue: 0.2) }
	public static var clear: Color { return Color(red: 0, green: 0, blue: 0, alpha: 0) }
}

#if os(iOS) || os(tvOS)
import UIKit

extension Color: NativeConvertible {

	public var native: UIColor {
		return UIColor(red: red.native, green: green.native, blue: blue.native, alpha: alpha.native)
	}
}

#elseif os(macOS)
import AppKit

extension Color: NativeConvertible {

	public var native: NSColor {
		return NSColor(deviceRed: red.native, green: green.native, blue: blue.native, alpha: alpha.native)
	}
}

#endif
