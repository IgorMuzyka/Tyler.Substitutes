
import Style

public enum TextAlignment: IntegerLiteralType, StyleValueLiteral {

	case left
    case right
	case center
	case justified
	case natural
}

#if os(iOS) || os(tvOS)
import UIKit

extension TextAlignment: NativeConvertible {

    public var native: NSTextAlignment? {
        return NSTextAlignment(rawValue: rawValue)
    }
}

#elseif os(macOS)
import AppKit

extension TextAlignment: NativeConvertible {

    public var native: NSTextAlignment? {
        return NSTextAlignment(rawValue: UInt(rawValue))
    }
}

#endif
