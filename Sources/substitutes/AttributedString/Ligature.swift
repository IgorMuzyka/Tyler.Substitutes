
import Style

extension AttributedString {

    public enum Ligature: Int, Codable {

        case none = 0
        case `default` = 1
    }
}

#if os(iOS) || os(tvOS) || os(macOS)
import Foundation

extension AttributedString.Ligature: NativeConvertible {

    public var native: NSNumber {
        return NSNumber(value: rawValue)
    }
}

#endif
