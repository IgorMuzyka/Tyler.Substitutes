
import Style

public struct EdgeInsets: Codable {

	public var top: Number
	public var left: Number
	public var bottom: Number
	public var right: Number

	public init(top: Number, left: Number, bottom: Number, right: Number) {
		self.top = top
		self.left = left
		self.bottom = bottom
		self.right = right
	}
}

#if os(iOS) || os(tvOS)
import UIKit

extension EdgeInsets: NativeConvertible {

	public var native: UIEdgeInsets {
		return UIEdgeInsets(top: top.native, left: left.native, bottom: bottom.native, right: right.native)
	}
}

#elseif os(macOS)
import AppKit

extension EdgeInsets: NativeConvertible {

	public var native: NSEdgeInsets {
		return NSEdgeInsets(top: top.native, left: left.native, bottom: bottom.native, right: right.native)
	}
}

#endif
