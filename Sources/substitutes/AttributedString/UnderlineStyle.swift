
import Style

extension AttributedString {

    public enum UnderlineStyle: Int, Codable {

        case none
        case single
        case thick
        case double
        case solid
        case dot
        case dash
        case dashDot
        case dashDotDot
        case byWord
    }
}

#if os(iOS) || os(tvOS) || os(macOS)
import Foundation

extension AttributedString.UnderlineStyle: NativeConvertible {

    public var native: NSNumber {
        return NSNumber(value: rawValue)
    }
}

#endif
