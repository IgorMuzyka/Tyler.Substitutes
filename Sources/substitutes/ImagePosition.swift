
import Style

public enum ImagePosition: UInt, StyleValueLiteral {

    case noImage = 0
    case imageOnly
    case imageLeft
    case imageRight
    case imageBelow
    case imageAbove
    case imageOverlaps
    case imageLeading
    case imageTrailing
}

#if os(macOS)
import AppKit

extension ImagePosition: NativeConvertible {

    public var native: NSControl.ImagePosition? {
        return NSControl.ImagePosition(rawValue: self.rawValue)
    }
}

#endif
