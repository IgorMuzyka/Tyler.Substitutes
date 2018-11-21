
import Style

public struct Size: Codable {

	public let width: Number
	public let height: Number

	public init(width: Number, height: Number) {
		self.width = width
		self.height = height
	}
}

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(tvOS) || os(macOS)

extension Size: NativeConvertible {

	public var native: CGSize {
		return CGSize(width: width.native, height: height.native)
	}
}

#endif
