
import Style

public enum LineBreakMode: IntegerLiteralType, StyleValueLiteral {

	case byWordWrapping
	case byCharWrapping
	case byClipping
	case byTruncatingHead
	case byTruncatingTail
	case byTruncatingMiddle
}

#if os(iOS) || os(tvOS)
import UIKit

extension LineBreakMode: NativeConvertible {

	public var native: NSLineBreakMode? {
		return NSLineBreakMode(rawValue: rawValue)
	}
}

#elseif os(macOS)
import AppKit

extension LineBreakMode: NativeConvertible {

    public var native: NSLineBreakMode? {
        return NSLineBreakMode(rawValue: UInt(rawValue))
    }
}

#endif
