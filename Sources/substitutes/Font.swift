
import Style

public struct Font: Codable {

	public let name: String
	public let size: Number

	public init(name: String, size: Number) {
		self.name = name
		self.size = size
	}
}

#if os(iOS) || os(tvOS)
import UIKit

extension Font: NativeConvertible {

	public var native: UIFont? {
		return UIFont(name: name, size: size.native)
	}
}

#elseif os(macOS)
import AppKit

extension Font: NativeConvertible {

	public var native: NSFont? {
		return NSFont(name: name, size: size.native)
	}
}

#endif
