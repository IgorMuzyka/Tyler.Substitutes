
import Style

public enum AppKitBezelStyle: UInt, StyleValueLiteral {

    case rounded = 1
    case regularSquare = 2
    case disclosure = 5
    case shadowlessSquare = 6
    case circular = 7
    case texturedSquare = 8
    case helpButton = 9
    case smallSquare = 10
    case texturedRounded = 11
    case roundRect = 12
    case recessed = 13
    case roundedDisclosure = 14
    case inline = 15
}

#if os(macOS)
import AppKit

extension AppKitBezelStyle: NativeConvertible {

    public var native: NSButton.BezelStyle? {
        return NSButton.BezelStyle(rawValue: self.rawValue)
    }
}

#endif
