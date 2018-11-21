
import Style

public struct ControlEvents: OptionSet, StyleValueLiteral { #warning("this might be unneeded, remove if it's true")

    public let rawValue: UInt

    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}

extension ControlEvents {

    public static var touchDown: ControlEvents { return ControlEvents(rawValue: 1) }
    public static var touchDownRepeat: ControlEvents { return ControlEvents(rawValue: 2) }
    public static var touchDragInside: ControlEvents { return ControlEvents(rawValue: 4) }
    public static var touchDragOutside: ControlEvents { return ControlEvents(rawValue: 8) }
    public static var touchDragExit: ControlEvents { return ControlEvents(rawValue: 32) }
    public static var touchUpInside: ControlEvents { return ControlEvents(rawValue: 64) }
    public static var touchCancel: ControlEvents { return ControlEvents(rawValue: 256) }
    public static var valueChanged: ControlEvents { return ControlEvents(rawValue: 4096) }
    public static var primaryActionTriggered: ControlEvents { return ControlEvents(rawValue: 8192) }
    public static var editingDidBegin: ControlEvents { return ControlEvents(rawValue: 65536) }
    public static var editingDidEndOnExit: ControlEvents { return ControlEvents(rawValue: 524288) }
    public static var allTouchEvents: ControlEvents { return ControlEvents(rawValue: 4095) }
    public static var applicationReserved: ControlEvents { return ControlEvents(rawValue: 251658240) }
    public static var systemReserved: ControlEvents { return ControlEvents(rawValue: 4026531840) }
    public static var allEvent: ControlEvents { return ControlEvents(rawValue: 4294967295) }
}

#if os(iOS) || os(tvOS)
import UIKit

extension ControlEvents: NativeConvertible {

    public var native: UIControl.Event {
        return UIControl.Event(rawValue: rawValue)
    }
}

#endif
