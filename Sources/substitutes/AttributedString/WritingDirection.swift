
import Style

extension AttributedString {

    public enum WritingDirection: Int, Codable {

        case natural
        case leftToRight
        case rightToLeft
    }
}

#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(iOS) || os(tvOS) || os(macOS)

extension AttributedString.WritingDirection: NativeConvertible {

    public var native: NSWritingDirection? {
        return NSWritingDirection(rawValue: rawValue)
    }
}

#endif
