
import Style

public enum ScrollerKnobStyle: Int, StyleValueLiteral {

    case `default` = 0
    case dark
    case light
}

#if os(macOS)
import AppKit

extension ScrollerKnobStyle: NativeConvertible {

    public var native: NSScroller.KnobStyle? {
        return NSScroller.KnobStyle(rawValue: self.rawValue)
    }
}

#endif
