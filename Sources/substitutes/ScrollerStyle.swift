
import Style

public enum ScrollerStyle: Int, StyleValueLiteral {

    case legacy = 0
    case overlay
}

#if os(macOS)
import AppKit

extension ScrollerStyle: NativeConvertible {

    public var native: NSScroller.Style? {
        return NSScroller.Style(rawValue: self.rawValue)
    }
}

#endif
