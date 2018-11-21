
import Style

public enum ImageScaling: UInt, StyleValueLiteral {

    case scaleProportionallyDown = 0
    case scaleAxesIndependently
    case scaleNone
    case scaleProportionallyUpOrDown
}

#if os(macOS)
import AppKit

extension ImageScaling: NativeConvertible {

    public var native: NSImageScaling? {
        return NSImageScaling(rawValue: self.rawValue)
    }
}

#endif
