
import Style

public struct Image: Codable {

	public let name: String

	public init(named name: String) {
		self.name = name
	}
}

#if os(iOS) || os(tvOS)
import UIKit

extension Image: NativeConvertible {

	public var native: UIImage? {
		return UIImage(named: name)
	}
}

#elseif os(macOS)
import AppKit

extension Image: NativeConvertible {

	public var native: NSImage? {
        return NSImage(named: NSImage.Name.init(stringLiteral: name))
	}
}

#endif
