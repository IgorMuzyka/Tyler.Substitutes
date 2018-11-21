
import Style

public struct Number {

	internal let value: Double

	public init(_ value: Double) {
		self.value = value
	}
}

extension Number: Codable {

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		value = try container.decode(Double.self)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(value)
	}
}

extension Number: ExpressibleByFloatLiteral {

	public init(floatLiteral value: FloatLiteralType) {
		self.init(value)
	}
}

extension Number: ExpressibleByIntegerLiteral {

	public init(integerLiteral value: IntegerLiteralType) {
		self.init(Double(value))
	}
}

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(tvOS) ||  os(macOS)

extension Number: NativeConvertible {

	public var native: CGFloat {
		return CGFloat(value)
	}
}

#endif
