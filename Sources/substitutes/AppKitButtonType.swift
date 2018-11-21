
import Style

public enum AppKitButtonType: UInt, StyleValueLiteral {

    case momentaryLight = 0
    case pushOnPushOff
    case toggle
    case `switch`
    case radio
    case momentaryChange
    case onOff
    case momentaryPushIn
    case accelerator
    case multiLevelAccelerator
}

#if os(macOS)
import AppKit

extension AppKitButtonType: NativeConvertible {

    public var native: NSButton.ButtonType? {
        return NSButton.ButtonType(rawValue: self.rawValue)
    }
}

#endif
